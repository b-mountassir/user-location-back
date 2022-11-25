# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)*

users = []

(0..5).each do |i|
  user = {
            email: "user#{i}@gmail.com",
            password: "user#{i} password"
          }
  users.push(User.create!(user))
end

questions = []
users.each do |user|
  (0..10).each do |i|
    question = {
      title: "question #{user.email}",
      content: user.email,
      location: i
    }
    questions.push(user.questions.create!(question))

  end
end

questions.each do |question|
  (0..10).each do |i|
    answer = {
      content: "answer #{i} #{ question.title }"
    }
    user_id = users[(Random.rand()*5).to_i].id
    question.answers.create!(answer.merge(user_id: user_id.to_str))
  end
end
