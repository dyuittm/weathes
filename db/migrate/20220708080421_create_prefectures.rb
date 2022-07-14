class CreatePrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :prefectures do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
