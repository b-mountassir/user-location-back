class Api::V1::AnswersController < ApplicationController
  before_action :set_api_v1_answer, only: %i[ show update destroy ]

  # GET /api/v1/answers
  def index
    @api_v1_answers = Api::V1::Answer.all

    render json: @api_v1_answers
  end

  # GET /api/v1/answers/1
  def show
    render json: @api_v1_answer
  end

  # POST /api/v1/answers
  def create
    @api_v1_answer = Api::V1::Answer.new(api_v1_answer_params)

    if @api_v1_answer.save
      render json: @api_v1_answer, status: :created, location: @api_v1_answer
    else
      render json: @api_v1_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/answers/1
  def update
    if @api_v1_answer.update(api_v1_answer_params)
      render json: @api_v1_answer
    else
      render json: @api_v1_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/answers/1
  def destroy
    @api_v1_answer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_answer
      @api_v1_answer = Api::V1::Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_answer_params
      params.fetch(:api_v1_answer, {})
    end
end
