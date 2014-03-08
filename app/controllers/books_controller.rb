class BooksController < ApplicationController

  before_action :require_login, :except => [:index, :show, :books]
  before_action :identify_user, :except => [:index, :show, :books]

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

	#this will be our main page, for now this page only shows all books in the database
	def index
		@books = Book.all
	end

    #this has to be changed when all the logic is implemented
      def books
        user = User.find(params[:user_id])
        @books = user.books
        render "index"
      end

	# homepage for each individual book
	def show
		# need to reset the book_id everytime rails starts since it's auto increment
		@book = Book.find(params[:id])
            if !session[:user_id].nil?
              @user = User.find(session[:user_id])
            else
              @user = ''
            end
		#need to add author and chapters
	end


	#form for a new book
	def new
	end

	#create a new book
	def create
		#need to obtain author information (through user session??)
  		b = Book.new
  		b.title = params[:title]
  		b.genre = params[:genre]
    	     b.image_url = params[:image_url]
    	     b.publish_date = params[:publish_date]
          b.summary = params[:summary]
    	     b.save

           a = Author.new
           a.book_id = b.id
           a.user_id = session[:user_id]
           a.save

    	#need to change the redirect path
    	redirect_to user_url(session[:user_id])
	end

	def edit
      @book = Book.find(params[:id])
      if Author.where("book_id = #{@book.id} and user_id = #{@user.id}") == []
        redirect_to book_url(@book.id), :notice => "You are not authorized to perform this action"
      end
    end

	def update
        b = Book.find(params[:id])
        b.title = params[:title]
        b.genre = params[:genre]
        b.image_url = params[:image_url]
        b.publish_date = params[:publish_date]
        b.summary = params[:summary]
        b.save

        redirect_to book_url(b.id), :notice => "Changes made to the book successfully"
	end

	def destroy
      @book = Book.find(params[:id])
      if Author.where("book_id = #{@book.id} and user_id = #{@user.id}") == []
        redirect_to book_url(@book.id), :notice => "You are not authorized to perform this action"
      end

      @book.destroy()

      redirect_to root_url, notice: "Book deleted successfully!"
	end

end
