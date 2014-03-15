class BooksController < ApplicationController

  before_action :require_login, :except => [:index, :show, :books, :search]
  before_action :identify_user, :except => [:index, :show, :books, :search]

  #Check if user is logged in before the action
  def require_login
    if session[:user_id].blank?
      redirect_to root_url, notice: "Login is required to perform this action!"
    end
  end

  #Identify the user before the action
  def identify_user
    @user = User.find_by(id: session[:user_id])
    if !@user
      redirect_to root_url, notice: "User not identified!"
    end
  end

  def index

    @books = Book.all

    #most commented books
    b = Hash.new

    @books.each do |book|
      b[book] = book.comments.count
    end

    @comment_counts = (b.sort_by{|k, v| v}.reverse)[0..3]

    #top rated books
    r = Hash.new

    @books.each do |book|
      r[book] = book.reviews.sum('rating')
    end

    @rating_counts = r.sort_by{|k,v| v}.reverse

    #productive authors
    users = User.all
    h = Hash.new

    users.each do |u|
      h[u] = u.books.count
    end

    @authors = (h.sort_by{|k, v| v}.reverse)[0..3]

    #newly published books
    @new_books = Book.order("publish_date desc").limit(4)

    #top 4 genres
    genre_count = Book.group(:genre).count.to_a.sort{|a,b| b[1] <=>a[1]}

    @top_genre = genre_count[0..3]

  end

  #homepage for each individual book
  def show
    @book = Book.find(params[:id])
    if !session[:user_id].nil?
      @user = User.find_by(:id => session[:user_id])
    end
  end

  def new
    @book = Book.new
    @author = Author.new
  end

  def new_author
    @author = Author.new
    @book = Book.find_by(:id => params[:book_id])
    @users = User.all
  end

  def add_author
    @author = Author.new
    @author.user_id = params[:user_id]
    @author.book_id = params[:book_id]

    if @author.save
      redirect_to book_url(params[:book_id]), :notice => "Author added successfully"
    else
      render "new_author"
    end
  end

  #create a new book
  def create
    @book = Book.new
    @book.title = params[:title]
    @book.genre = params[:genre]
    @book.image_url = params[:image_url]
    @book.publish_date = params[:publish_date]
    @book.summary = params[:summary]

    @author = Author.new

    if @book.save
      @author.book_id = @book.id
      @author.user_id = session[:user_id]

      if @author.save
        redirect_to user_url(session[:user_id]), :notice => "Book added successfully!"
      else
        render "new"
      end
    else
      render "new"
    end
  end

    def edit
      @book = Book.find(params[:id])
      @author = Author.new
      if Author.where("book_id = #{@book.id} and user_id = #{@user.id}") == []
        redirect_to book_url(@book.id), :notice => "You are not authorized to perform this action"
      end
    end

    def update
      @book = Book.find(params[:id])
      @book.title = params[:title]
      @book.genre = params[:genre]
      @book.image_url = params[:image_url]
      @book.publish_date = params[:publish_date]
      @book.summary = params[:summary]

      if @book.save
        redirect_to book_url(@book.id), :notice => "Changes made to the book successfully"
      else
        render "edit"
      end
    end

    def destroy
      book = Book.find(params[:id])

      book.destroy()

      redirect_to root_url, notice: "Book deleted successfully!"
    end

    def search
      @search_results = nil
      @term = params[:term]

      if params[:term] != nil
        @search_results = Book.search(params[:term]).order("created_at desc")
        if @search_results.blank?
          @search_results = nil
        end
      end
    end

end
