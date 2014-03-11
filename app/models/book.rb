class Book < ActiveRecord::Base
  has_many :chapters
  has_many :reviews
  has_many :authors
  has_many :wish_lists
  has_many :comments, :through => :chapters
  has_many :users, :through => :authors

  def self.search(query)
  	where("title like ?", "%#{query}%")
  end
end
