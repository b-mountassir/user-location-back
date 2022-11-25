module Questions
  class QuestionsBulkCreatorService

    def initialize(questions, liked_question_ids)
      @questions = questions
      @liked_questions = liked_question_ids
    end

    def check_liked_questions_and_tag_them
      @questions.map do | question |
        if @liked_questions.include?(question.id)
          is_liked(question, true)
        else
          is_liked(question)
        end
      end
    end

    private
    def is_liked(question, isLiked=false)
      return {
        id: question.id.to_str,
        title: question.title,
        content: question.content,
        location: question.location,
        is_liked: isLiked,
        created_at: question.created_at,
        updated_at: question.updated_at
      }
    end
  end
end