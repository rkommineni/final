class AddColumnToBooks < ActiveRecord::Migration
  def change
    add_column :books, :summary, :string
  end
end
