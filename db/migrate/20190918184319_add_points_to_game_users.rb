class AddPointsToGameUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :game_users, :points, :integer, default: 0
  end
end
