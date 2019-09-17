class CreateAnsweredQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :answered_questions do |t|
      t.integer :game_id
      t.integer :question_id

      t.timestamps
    end
  end
end
