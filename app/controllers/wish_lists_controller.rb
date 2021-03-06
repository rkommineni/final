class WishListsController < ApplicationController

  before_action :require_login
  before_action :identify_user
  before_action :redirect_user, :except => [:show, :create, :destroy]

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

  def redirect_user
    redirect_to root_url, notice: "You are not authorized to perform this action!"
  end

  def show
	@wishlists = WishList.joins(:book).where("user_id = #{session[:user_id]}")
  end

  def create
    w = WishList.new
    w.user_id = session[:user_id]
    w.book_id = params[:book_id]

    if w.save
      redirect_to book_url(params[:book_id]), notice: "Book added to wishlist successfully!"
    else
      redirect_to book_url(params[:book_id]), notice: "Failed to add the book to the wishlist!"
    end
  end

  def destroy
    w = WishList.where("user_id = #{session[:user_id]} and book_id = #{params[:book_id]}").first

    w.destroy()

    redirect_to book_url(params[:book_id]), notice: "Book removed from wishlist successfully!"
  end

end
