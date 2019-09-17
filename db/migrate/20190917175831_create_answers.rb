class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :description
      t.integer :question_id

      t.timestamps
    end
  end
end
