class BooksController < ApplicationController
	
	#this will be our main page, for now this page only shows all books in the database
	def index  
		@books = Book.all
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
    	b.publish_date = Time.now
    	b.save

    	#need to change the redirect path
    	redirect_to books_path
	end

	def edit
	end

	def update
	end

	def destroy
	end

end
