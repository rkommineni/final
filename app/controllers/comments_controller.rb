class CommentsController < ApplicationController

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

    if params[:chapter_id].blank?
      redirect_to root_url, :notice => "It is not a valid action!"
    end
  end

  def index
    redirect_to chapter_url(params[:chapter_id])
  end

  def show
    redirect_to chapter_url(params[:chapter_id])
  end

  def new
    @chapter = Chapter.find(params[:chapter_id])
  end

  def create
    c = Comment.new
    c.description = params[:description]
    c.user_id = session[:user_id]
    c.chapter_id = params[:chapter_id]
    c.save

    redirect_to chapter_url(params[:chapter_id]), :notice => "Comment added successfully"
  end

  def edit
    redirect_to chapter_url(params[:chapter_id]), :notice => "You can not edit a comment"
  end

  def update
    redirect_to chapter_url(params[:chapter_id]), :notice => "You can not edit a comment"
  end

  def destroy
    @comment = Comment.find(params[:id])

    @comment.destroy()

    redirect_to book_url(params[:book_id]), notice: "Comment deleted successfully!"
  end

end
