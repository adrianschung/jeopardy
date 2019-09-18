class AddExcludedToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :excluded, :json
  end
end
