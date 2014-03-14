class Comment < ActiveRecord::Base
  #model associations
  belongs_to :user
  belongs_to :chapter

  #model validations
  validates :user_id, presence: true
  validates :chapter_id, presence: true

  #model callbacks
  before_save :check_in_chapters_users

  protected
  def check_in_chapters_users
    if Chapter.find_by(:id => chapter_id) && User.find_by(:id => user_id)
      return true
    else
      return false
    end
  end

end
