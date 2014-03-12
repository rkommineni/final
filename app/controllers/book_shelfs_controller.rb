class BookShelfsController < ApplicationController

    before_action :require_login
    before_action :identify_user

  #before every action identify the user that is logged in
  def identify_user
    @user = User.find_by(id: session[:user_id])
    if !@user
      redirect_to root_url, notice: "User not identified!"
    end
  end

  #before every action check if any user is logged in
  def require_login
    if session[:user_id].blank?
      redirect_to root_url, notice: "Login is required to perform this action!"
    end
  end


  def show
    @book = BookShelf.joins(:book).find_by(:user_id => session[:user_id])
  end

  def index
  end

  def new
  end

  def create
    #also delete the same entry in the wishlist
  end

  def delete

  end
end
