class Chapter < ActiveRecord::Base
  has_many :comments
  belongs_to :books
end
