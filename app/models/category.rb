class Category < ApplicationRecord
  has_many :questions
  has_many :game_categories, dependent: :destroy
  has_many :games, through: :game_categories
end
