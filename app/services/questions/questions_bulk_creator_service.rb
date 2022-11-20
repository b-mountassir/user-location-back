module Questions
  class QuestionsBulkCreatorService
    LIMIT = 1000

    def initialize(questions)
      @questions = questions['questions'].map { |question| question.to_h }
    end

    def check_limit_and_insert
      if @questions.length <= LIMIT
        return Question.collection.insert_many(@questions)
      end
    end
  end
end