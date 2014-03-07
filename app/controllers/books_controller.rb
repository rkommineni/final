class BooksController < ApplicationController

	#this will be our main page, for now this page only shows all books in the database
	def index
		@books = Book.all

		#for showing most popular books based on ratings

		#for showing most commented books

		#for showing authors who published large amount of books

		#for showing newly published books
		@new_books = Book.order("publish_date desc").limit(4)

		#for showing top 4 genres (that has most books)
		genre_count = Book.group(:genre).count.to_a.sort{|a,b| b[1] <=>a[1]}
		@top_genre = genre_count[0..3]
	end

      def books
        user = User.find(params[:user_id])
        @books = user.books
        render "index"
      end

	# homepage for each individual book
	def show
		the_book_id = params["id"]
		@book = Book.find_by :id => the_book_id
		@authors = @book.users
		@chapters = @book.chapters
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
