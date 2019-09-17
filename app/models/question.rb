class Question < ApplicationRecord
  belongs_to :category
  has_one :answer
  has_many :answered_questions
end
