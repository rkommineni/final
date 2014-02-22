class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.date :publish_date
      t.string :genre
      t.text :image_url

      t.timestamps
    end
  end
end
