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
    @chapter = Chapter.new
  end

  def create
    @chapter = Chapter.new
    @chapter.title = params[:title]
    @chapter.book_id = @book.id
    @chapter.description = params[:description]
    @chapter.content_url = params[:content_url]

    if @book.chapters != []
      @chapter.number = @book.chapters.order("number desc").first.number + 1
    else
      @chapter.number = 1
    end

    if @chapter.save
      redirect_to chapters_url + "?book_id=#{@book.id}", :notice => "Chapter added successfully"
    else
      render "new"
    end
  end

  def show
    @chapter = Chapter.find(params[:id])
  end

  def edit
  end

# define a method for common logic between create and update
  def update
    @chapter.title = params[:title]
    @chapter.book_id = @book.id
    @chapter.description = params[:description]
    @chapter.content_url = params[:content_url]
    @chapter.number = @book.chapters.order("number desc").first.number + 1

    if @chapter.save
      redirect_to chapters_url + "?book_id=#{@book.id}", :notice => "Changes made to the chapter successfully"
    else
      render "edit"
    end
  end

  def destroy
    chapter.destroy()

    redirect_to chapters_url + "?book_id=#{@book.id}", notice: "Chapter deleted successfully!"
  end

end
