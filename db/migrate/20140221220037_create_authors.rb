class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.int :book_id
      t.int :user_id

      t.timestamps
    end
  end
end
