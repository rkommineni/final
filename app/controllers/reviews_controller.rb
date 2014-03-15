class ReviewsController < ApplicationController

  before_action :require_login, :except => [:index, :show]
  before_action :identify_user, :except => [:index, :show]

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

    if params[:book_id].blank?
      redirect_to root_url, :notice => "It is not a valid action!"
    end
  end

  def index
    redirect_to book_url(params[:book_id])
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @review = Review.new
    @review.description = params[:description]
    @review.user_id = session[:user_id]
    @review.book_id = params[:book_id]
    @review.rating = params[:rating]

    if @review.save
      redirect_to book_url(params[:book_id]), :notice => "Review added successfully"
    else
      render "new"
    end
  end

  def edit
    @review = Review.find(params[:id])
      if Review.where("id = #{@review.id} and user_id = #{@user.id}") == []
        redirect_to book_url(@book.id), :notice => "You are not authorized to perform this action"
      end
  end

  def update
    @review = Review.find(params[:id])
    @review.description = params[:description]
    @review.user_id = session[:user_id]
    @review.book_id = params[:book_id]
    @review.rating = params[:rating]

    if @review.save
      redirect_to book_url(params[:book_id]), :notice => "Review updated successfully"
    else
      render "edit"
    end
  end

  def destroy
    @review = Review.find(params[:id])

    @review.destroy()

    redirect_to book_url(params[:book_id]), notice: "Review deleted successfully!"
  end

end
