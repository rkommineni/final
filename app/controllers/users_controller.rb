class UsersController < ApplicationController

  before_action :require_login, :except => [:create, :new, :show]
  before_action :identify_user, :except => [:create, :new, :show]

  #Check if any user is logged in before the action
  def require_login
    if session[:user_id].blank?
      redirect_to root_url, notice: "Login is required to perform this action!"
    end
  end

  #Identify the logged in user before the action
  def identify_user
    @user = User.find_by(id: session[:user_id])
    if !@user
      redirect_to root_url, notice: "User not identified!"
    end
  end

  #Can not access the list of all the users of the application
  def index
    redirect_to root_url
  end

  def new
    @user = User.new
  end

  #Create a new user profile
  def create
    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.username = params[:username]
    @user.image_url = params[:image_url]

    #bcrypt for secure password
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thanks for registering!"
    else
      render "new"
    end
  end

  #implement following functionalities only if the right user is logged in, use filters
  def show
    @user = User.find_by(:id => params[:id])
  end

  def update
    if @user.update_attributes(:username => params[:username],  :name => params[:name], :image_url => params[:image_url]) 
      redirect_to "/users/#{@user.id}", notice: "Changes saved successfully!"
    else
      render "edit"
    end
  end

  def newPassword
    #render change password form
  end

  def change
    #change the password
    #bcrypt for secure password
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if @user.save
      redirect_to "/users/#{@user.id}", notice: "Changes saved successfully!"
    else 
      render 'newPassword'
    end
  end


  def destroy
    reset_session
    @user.destroy()

    redirect_to root_url, notice: "User account deleted successfully!"
  end

end

