class ChangeStringToText < ActiveRecord::Migration
  def change
    change_column, :books, :summary, :text
  end
end
