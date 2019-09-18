class GameUser < ApplicationRecord
  belongs_to :game
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :game_id
  after_save :max_game_users

  private
  
  def max_game_users
    if game.game_users.count == 3
      game.update(status: :full)
    end
  end
end
