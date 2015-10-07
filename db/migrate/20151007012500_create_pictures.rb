class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :user, index: true, foreign_key: true
      t.date :date
      t.string :thumbnail
      t.string :standard_res
      t.string :latitude
      t.string :longitude
      t.string :insta_id

      t.timestamps null: false
    end
  end
end
