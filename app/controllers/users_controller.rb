class UsersController < ApplicationController

  before_action :require_login, :except => [:create, :new, :show]
  before_action :identify_user, :except => [:create, :new, :show]

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

  #Creae a new user profile
  def create
    #Check if email is registered already
    #decide if one email can take more than one username
    if User.find_by(email: params[:email])
      redirect_to root_url, notice: "An account is registered with the given email address."
    else
      #check if username exists
      if User.find_by(username: params[:username])
        redirect_to root_url, notice: "Username already exists."
      else
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
    end
  end

  #implement following functionalities only if the right user is logged in, use filters
  def show
    @private_profile = false
    current_user = params[:user_id]
    if session[:user_id].blank? || session[:user_id] != current_user
      @private_profile = true
    end 
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

