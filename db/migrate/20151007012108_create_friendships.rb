class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friends, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
