class AddQuestionAndAnswererToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :answerer_id, :integer
    add_column :games, :question_id, :integer
  end
end
