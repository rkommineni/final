class CreateBookShelves < ActiveRecord::Migration
  def change
    create_table :book_shelves do |t|
      t.int :user_id
      t.int :book_id

      t.timestamps
    end
  end
end
