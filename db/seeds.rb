# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |x|
  x += 1
  category = Category.create(name: "Category #{x}")
  Answer.create(description: "Fake answer #{x}")
  5.times do |y|
    y += 1
    question = category.questions.create(description: "Category #{x} Question #{y}", value: (200*y))
    question.create_answer(description: "Category #{x} Question #{y} Answer")
  end
end