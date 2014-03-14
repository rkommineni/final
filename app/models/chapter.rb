class Chapter < ActiveRecord::Base
  #model associations
  has_many :comments, :dependent => :destroy
  belongs_to :book

  #model validations
  validates :title, presence: true
  validates :description, presence: true
  validates :book_id, presence: true
  #add a content url and validate it

  #model callbacks
  before_save :check_in_books

  protected
  def check_in_books
    if Book.find_by(:id => book_id)
      return true
    else
      return false
    end
  end

end
