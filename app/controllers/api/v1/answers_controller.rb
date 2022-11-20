class Api::V1::AnswersController < ApplicationController
  before_action :set_question
  before_action :set_answer, only: %i[ show update destroy ]
  before_action :authenticate_user!, except: %i[ index ]
  PAGINATION_LIMIT = 5.freeze

  # GET /api/v1/answers
  def index
    @answers = @question.answers.limit(PAGINATION_LIMIT).offset(offset)

    render json: @answers
  end

  # POST /api/v1/answers
  def create
    @answer = @question.answers.new(answer_params.merge(user_id: current_user.id))

    if @answer.save
      render json: @answer, status: :created, location: @answer
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
      @answer = Answer.find(params[:id])
    end

    def offset
      params.fetch(:offset, 0).to_i
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.permit(:question_id, :content, :id, :offset)
    end
end
