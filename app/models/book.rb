class Book < ActiveRecord::Base
  #model associations
  has_many :chapters, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :authors, :dependent => :destroy
  has_many :wish_lists, :dependent => :destroy
  has_many :comments, :through => :chapters
  has_many :users, :through => :authors

  #model validations
  validates :title, presence: true
  validates :publish_date, presence: true
  validates :genre, presence: true
  validates :summary, presence: true
  #add a content url and validate it

  def self.search(query)
  	where("title LIKE ?", "%#{query}%")
  end
end
