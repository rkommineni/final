class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :description
      t.date :publish_date
      t.int :user_id
      t.int :book_id
      t.int :rating

      t.timestamps
    end
  end
end
