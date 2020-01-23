class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.boolean :confirmed, default: false
      t.references :friend
      t.references :user

      t.timestamps
    end

    add_index :friendships, [:user_id, :friend_id], unique: true
  end
end
