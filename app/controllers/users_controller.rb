class UsersController < ApplicationController

  before_action :require_login, :except => [:create, :new, :show, :books]
  before_action :identify_user, :except => [:create, :new, :show, :books]

  #before every action identify the user that is logged in
  def identify_user
    @user = User.find_by(id: session[:user_id])
    if !@user
      redirect_to root_url, notice: "User not identified!"
    end
  end

  #before every action check if any user is logged in
  def require_login
    if session[:user_id].blank?
      redirect_to root_url, notice: "Login is required to perform this action!"
    end
  end

  def index
    #redirect to root page as we do not want to show the list of users to anyone even
    #if any user is logged in (check this with Linda)
    redirect_to root_url
  end

  def books
    show_user = User.find_by(:id => params[:user_id])
    @books = show_user.books
  end

  #Creae a new user profile
  def create
    #Check if email is registered already
    #decide if one email can take more than one username
    #check for industry strength passwords and equal confirm passwords
    #check if username exists
    #this can be moved to another method in future(also to be used by update method)
    user = User.new
    user.name = params[:name]
    user.email = params[:email]
    user.username = params[:username]
    user.image_url = params[:image_url]

    #have to implement bcrypt for secure password i.e., not saving password
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    user.save

    #also check if database save was successful without any errors
    #start the session for the user immediately after sign up
    session[:user_id] = user.id
    redirect_to root_url, notice: "Thanks for registering!"
  end

  #implement following functionalities only if the right user is logged in, use filters
  def show
    @show_user = User.find_by(:id => params[:id])
  end

  def edit
  end

  def update
    #check on all database activites
    @user.name = params[:name]
    #right now do not let user to change username and email address
    #@user.email = params[:email]
    #@user.username = params[:username]
    @user.image_url = params[:image_url]

    @user.save

    redirect_to "/users/:#{@user.id}", notice: "Changes saved successfully!"
  end

  def destroy
    #check on all database activites
    @user.destroy()

    redirect_to root_url, notice: "User account deleted successfully!"
  end

end

