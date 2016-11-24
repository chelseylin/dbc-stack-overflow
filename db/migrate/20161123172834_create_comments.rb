class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :description, { null: false }
      t.integer :user_id, { null: false }
      t.string :content_type, { null: false }
      t.integer :content_id, { null: false }

      t.timestamps
    end
  end
end
