class Answer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, type: String
  belongs_to :question
  belongs_to :user
end
