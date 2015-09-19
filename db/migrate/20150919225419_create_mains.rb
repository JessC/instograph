class CreateMains < ActiveRecord::Migration
  def change
    create_table :mains do |t|
      t.string :caption

      t.timestamps null: false
    end
  end
end
