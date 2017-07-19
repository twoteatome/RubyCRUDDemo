class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
  end

  def create
    user = User.find_by name: params[:session][:name].downcase
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Login success"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
  	session.delete :user_id
    flash[:success] = "You are logged out"
    redirect_to login_path
  end
end
