class BooksController < ApplicationController

	#this will be our main page, for now this page only shows all books in the database
	def index
		@books = Book.all
	end

      def books
        user = User.find(params[:user_id])
        @books = user.books
        render "index"
      end

	# homepage for each individual book
	def show
		# need to reset the book_id everytime rails starts since it's auto increment
		the_book_id = params["id"]
		@book = Book.find_by :id => the_book_id
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
	end

	def update
	end

	def destroy
	end

end
