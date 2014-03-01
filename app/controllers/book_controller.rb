class BookController < ApplicationController
  def show
  	the_book_id = params[:id]
  	@book = Book.find_by :id => the_book_id
  	@chapters = Chapter.all
  end

  def destroy
  	the_book_id = params[:id]
  	b = Book.find_by(:id => the_book_id)
  	b.destroy
  	redirect_to root
  end

  def create
  	b = Book.new
  	b.title = params[:title]
  	b.genre = params[:genre]
    b.image_url = params[:image_url]
    b.publish_date = Time.now
    b.save
    redirect_to root
  end

  def edit
  	the_book_id = params[:id]
  	book = Book.find_by(:id => the_book_id)
  	book.title = params[:title]
  	book.genre = params[:genre]
  	book.image_url = params[:image_url]
  	book.save
  	redirect_to root
end
