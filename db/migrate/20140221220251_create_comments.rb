class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :description
      t.date :publish_date
      t.int :user_id
      t.int :chapter_id

      t.timestamps
    end
  end
end
