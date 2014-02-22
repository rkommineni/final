class WishList < ActiveRecord::Base
  belongs_to :users
  belongs_to :books
end
