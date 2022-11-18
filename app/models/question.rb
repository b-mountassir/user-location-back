class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  field :id, type: BSON::ObjectId
  field :title, type: String
  field :content, type: String
  field :location, type: String
  has_many :answers, dependent: :destroy
  belongs_to :user
end
