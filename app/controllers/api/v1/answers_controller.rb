class Api::V1::AnswersController < ApplicationController
  before_action :set_question
  before_action :set_answer, only: %i[ show update destroy ]
  before_action :authenticate_user!, except: %i[ index ]
  PAGINATION_LIMIT = 5.freeze

  # GET /api/v1/answers
  def index
    @answers = @question.answers.order(created_at: -1).limit(PAGINATION_LIMIT).offset(offset)

    @answers = @answers.map do |answer|
      {
        id: answer.id.to_str,
        content: answer.content,
        creted_at: answer.created_at,
        updated_at: answer.updated_at,
        question_id: answer.question_id.to_str
      }
    end
    if @answers.length > 0
      render json: @answers
    else
      render error: {message: 'no answers left'}
    end
  end

  # POST /api/v1/answers
  def create
    @answer = @question.answers.new(answer_params.merge(user_id: current_user.id))

    if @answer.save
      render json: {message: 'success'}
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/answers/1
  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/answers/1
  def destroy
    @answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(answer_params[:question_id])
    end

    def set_answer
      @answer = Answer.find(answer_params[:id])
    end

    def offset
      params.fetch(:offset, 0).to_i
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.permit(:question_id, :content, :id, :offset)
    end
end
