class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :set_question, only: %i[ show update destroy like_a_question ]
  before_action :authenticate_user!, except: %i[ show index ]

  PAGINATION_LIMIT = 10.freeze
  # GET /questions
  def index
    questions = Question.all.order(created_at: -1).limit(PAGINATION_LIMIT).offset(offset)
    liked_questions =  LikedQuestion.where(user_id: current_user.id).pluck(:question_id)

    questions = Questions::QuestionsBulkCreatorService.new(questions, liked_questions).check_liked_questions_and_tag_them
    render json: questions
  end

  def liked_questions
    liked_questions = LikedQuestion.where(user_id: current_user.id).limit(PAGINATION_LIMIT).offset(offset).pluck(:question_id)
    questions = Question.find(liked_questions)

    questions = Questions::QuestionsBulkCreatorService.new(questions, liked_questions).check_liked_questions_and_tag_them
    render json: questions
  end

  def like_a_question
    if @question.liked_question.where(user_id: current_user.id).pluck(:user_id).include?(current_user.id)
      @question.liked_question.where(user_id: current_user.id).delete_all
    else
      liked_question = current_user.liked_questions.new(question_id: @question.id)
      if liked_question.save
        render json: { data: "question liked successfully" }
      end
    end
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # POST /questions
  def create
    @question = Question.new(question_params.merge(user_id: current_user.id))

    if @question.save
      render json: {message: 'success'}
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    if current_user.id == @question.user_id
      @question.destroy
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end
    def offset
      params.fetch(:offset, 0).to_i
    end
    # Only allow a list of trusted parameters through.
    def question_params
      params.permit(:id, :title, :content, :location, :offset, :location, :favorite)
    end
end
