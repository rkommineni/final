class ChapterController < ApplicationController
  def show
  	the_chapter_id = params[:id]
  	the_book_id = params[:book_id]
  	@chapter = Chapter.where{:book_id => the_book_id, :id => the_chapter_id}
  end

  def destroy
  	the_book_id = params[:book_id]
  	the_chapter_id = params[:id]
  	c = Chapter.where{:book_id => the_book_id, :id => the_chapter_id}
  	c.destroy
  	redirect_to book_url
  end

  def create
  	c = Chapter.new
  	c.title = params[:title]
  	c.description = params[:description]
  	c.content_url = params[:content_url]
  	c.save
  	redirect_to book_url
  end

  def edit
  	the_book_id = params[:book_id]
  	the_chapter_id = params[:id]
  	c = Chapter.where{:book_id => the_book_id, :id => the_chapter_id}
  	c.title = params[:title]
  	c.description = params[:description]
  	c.content_url = params[:content_url]
  	c.save
  	redirect_to book_url
  end

 end
