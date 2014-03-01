class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :description
      t.date :publish_date
      t.integer :user_id
      t.integer :book_id
      t.integer :rating

      t.timestamps
    end
  end
end
