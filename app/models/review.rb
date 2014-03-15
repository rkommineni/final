class Review < ActiveRecord::Base
  #model associations
  belongs_to :book
  belongs_to :user

 #model validations
  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :rating, presence: true

  #model callbacks
  before_save :check_in_books_users

  protected
  def check_in_books_users
    if Book.find_by(:id => book_id) && User.find_by(:id => user_id)
      return true
    else
      return false
    end
  end

end
