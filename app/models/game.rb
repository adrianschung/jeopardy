class Game < ApplicationRecord
  has_many :answered_questions
  has_many :game_categories, dependent: :destroy
  has_many :categories, through: :game_categories

  def answered_ids
    answered_questions.pluck(:question_id)
  end
end
