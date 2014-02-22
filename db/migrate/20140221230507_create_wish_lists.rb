class CreateWishLists < ActiveRecord::Migration
  def change
    create_table :wish_lists do |t|
      t.int :user_id
      t.int :book_id

      t.timestamps
    end
  end
end
