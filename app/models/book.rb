class Book < ActiveRecord::Base
  has_many :chapters
  has_many :reviews
  has_many :comments, :through => :chapters
  has_many :users, :through => :authors
end
