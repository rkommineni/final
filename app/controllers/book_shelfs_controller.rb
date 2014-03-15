class BookShelfsController < ApplicationController

  before_action :require_login
  before_action :identify_user
  before_action :redirect_user, :except => [:show, :create, :destroy]

  #before every action check if any user is logged in
  def require_login
    if session[:user_id].blank?
      redirect_to root_url, notice: "Login is required to perform this action!"
    end
  end

  #before every action identify the user that is logged in
  def identify_user
    @user = User.find_by(id: session[:user_id])
    if !@user
      redirect_to root_url, notice: "User not identified!"
    end
  end

  def redirect_user
    redirect_to root_url, notice: "You are not authorized to perform this action!"
  end

  def show
    @bookshelfs = BookShelf.joins(:book).where("user_id = #{session[:user_id]}")
  end

  def create
    bs = BookShelf.new
    bs.user_id = session[:user_id]
    bs.book_id = params[:book_id]

    if bs.save
      redirect_to book_url(params[:book_id]), notice: "Book added to bookshelf successfully!"
    else
      redirect_to book_url(params[:book_id]), notice: "Failed to add the book to the bookshelf!"
    end
  end

  def destroy
    bs = BookShelf.where("user_id = #{session[:user_id]} and book_id = #{params[:book_id]}").first

    bs.destroy()

    redirect_to book_url(params[:book_id]), notice: "Book removed from bookshelf successfully!"
  end

end
