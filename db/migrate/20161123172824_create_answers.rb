class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :description, { null: false }
      t.integer :user_id, { null: false }
      t.integer :question_id, { null: false }
      t.integer :best_answer, { null: false, limit: 1 } # 0 - false; # 1 - true

      t.timestamps
    end
  end
end
