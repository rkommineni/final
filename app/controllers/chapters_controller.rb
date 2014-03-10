class ChaptersController < ApplicationController

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
    current_user = User.find(session[:user_id])
    if !params[:id].blank?
      @chapter = Chapter.find(params[:id])
      @book = @chapter.book
    else
      @book = Book.find(params[:book_id])
    end
    if Author.where("book_id = #{@book.id} and user_id = #{current_user.id}") == []
      redirect_to root_url, notice: "You are not authorized to perform this action!"
    end
  end

  def index
    @book = Book.find(params[:book_id])
  end

  def new
  end

  def create
    c = Chapter.new
    c.title = params[:title]
    c.book_id = @book.id
    c.description = params[:description]
    c.content_url = params[:content_url]
    if @book.chapters != []
      c.number = @book.chapters.order("number desc").first.number + 1
    else
      c.number = 1
    end
    c.save

    redirect_to chapters_url + "?book_id=#{@book.id}", :notice => "Chapter added successfully"
  end

  def show
    @chapter = Chapter.find(params[:id])

    if !session[:user_id].nil?
      @user = User.find(session[:user_id])
    else
      @user = ''
    end
  end

  def edit
  end

# define a method for common logic between create and update
  def update
    chapter.title = params[:title]
    chapter.book_id = @book.id
    chapter.description = params[:description]
    chapter.content_url = params[:content_url]
    chapter.number = @book.chapters.order("number desc").first.number + 1
    chapter.save

    redirect_to chapters_url + "?book_id=#{@book.id}", :notice => "Changes made to the chapter successfully"
  end

  def destroy
    @chapter.destroy()

    redirect_to chapters_url + "?book_id=#{@book.id}", notice: "Chapter deleted successfully!"
  end

end
