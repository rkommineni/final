class User < ActiveRecord::Base
  #model associations
  has_many :authors, :dependent => :destroy
  has_many :books, :through => :authors
  has_many :comments, :dependent => :destroy
  has_many :wish_lists, :dependent => :destroy
  has_many :book_shelves, :dependent => :destroy

  #model validations
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { :message => " is associated with another account" }
  validates :username, presence: true
  validates :username, uniqueness: { :message => " is already taken. Please choose another username" }
  
  validates :password, presence: true
  validates :password, length: { in: 6..15, :message => " should contain 6 to 15 characters" }
  validates :password_confirmation, presence: true

  validates :password, presence: true, :on => :create
  validates :password, length: { in: 6..15, :message => " should contain 6 to 15 characters" }, :on => :create
  validates :password_confirmation, presence: true, :on => :create
  #validate email address based on the syntax

  #using password digest
  has_secure_password
end
