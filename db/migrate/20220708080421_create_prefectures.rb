class CreatePrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :prefectures do |t|
      t.string :name
      t.string :name_prefecture
      t.timestamps
    end
  end
end
