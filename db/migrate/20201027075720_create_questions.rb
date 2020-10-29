class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :question_text, null: false
      t.string :level, null: false
      t.integer :score, null: false
      t.integer :answers_count, null: false

      t.timestamps
    end
  end
end
