class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :title
      t.integer :book_id
      t.text :description
      t.text :content_url

      t.timestamps
    end
  end
end
