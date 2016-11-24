class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value, { null: false, limit: 1} # 1 - up-vote; -1 down-vote
      t.integer :user_id, { null: false }
      t.string :target_type, { null: false }
      t.integer :target_id, { null: false }

      t.timestamps
    end
  end
end
