class User < ApplicationRecord
  has_secure_password
  has_many :game_users
  has_many :games, through: :game_users
  validates :name, presence: true, uniqueness: true
end
