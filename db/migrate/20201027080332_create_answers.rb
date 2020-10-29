class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.integer :question_id, null: false
      t.string :answer_text, null: false
      t.boolean :is_correct, null: false

      t.timestamps
    end
  end
end
