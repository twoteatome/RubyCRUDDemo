class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :require_login

  def require_login
  	@current_user ||= User.find_by id: session[:user_id]
    unless @current_user.present?
      redirect_to login_path
    end
  end
end
