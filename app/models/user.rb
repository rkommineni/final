class User < ActiveRecord::Base
  has_many :books, :through => :authors
  has_many :comments
  has_many :wish_lists
  has_many :book_shelves
end