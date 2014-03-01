class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :description
      t.date :publish_date
      t.integer :user_id
      t.integer :chapter_id

      t.timestamps
    end
  end
end
