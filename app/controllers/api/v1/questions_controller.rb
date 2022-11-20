class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :set_question, only: %i[ show update destroy ]
  before_action :authenticate_user!, except: %i[ show index ]

  PAGINATION_LIMIT = 10.freeze
  # GET /questions
  def index
    @questions = Question.all.limit(PAGINATION_LIMIT).offset(offset)

    render json: @questions
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # POST /questions
  def create
    @question = Question.new(question_params.merge(user_id: current_user.id))

    if @question.save
      render json: @question, status: :created, location: @question
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
      params.require(:question).permit(questions: [:title, :content, :location, :id])
    end
end
