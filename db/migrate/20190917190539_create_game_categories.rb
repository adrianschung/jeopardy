class CreateGameCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :game_categories do |t|
      t.integer :game_id
      t.integer :category_id

      t.timestamps
    end
  end
end
