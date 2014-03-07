class SessionsController < ApplicationController

  before_action :not_allowed, :except[:create, :destroy, :new]

  def not_allowed
    #redirect to root page as we do not want to show the list of users to anyone
    redirect_to root_url, notice: "Not allowed to perform this action!"
  end

  def create
    username = params[:username]

    user = User.find_by(username: username)
    if user
      #authenticate only available after using bcrypt for password
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_url, notice: "Welcome Back, #{user.name}"
      else
        redirect_to root_url, notice: "Incorrect password!"
      end
    else
       redirect_to root_url, notice: "Username does not exist!"
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Goodbye."
  end

end
