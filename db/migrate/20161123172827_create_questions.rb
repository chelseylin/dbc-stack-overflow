class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title, { null: false }
      t.string :description, { null: false }
      t.integer :user_id, { null: false }
      t.integer :views, { default: 0 }

      t.timestamps
    end
  end
end
