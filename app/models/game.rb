class Game < ApplicationRecord
  has_many :answered_questions
  has_many :game_categories, dependent: :destroy
  has_many :categories, through: :game_categories
  has_many :game_users
  has_many :users, through: :game_users
  enum status: [:waiting, :full, :selecting, :answering, :finished]
  after_create :set_waiting
  
  def answered_ids
    answered_questions.pluck(:question_id)
  end

  def answerer
    User.find(answerer_id)
  end

  def first_user
    game_users.first.user
  end

  def question
    Question.find(question_id)
  end

  private

  def set_waiting
    update(status: :waiting)
  end
end
