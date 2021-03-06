class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :authenticate_user, :cookie_set
  
  def current_user
    if session[:user_id]
      @current_user ||= fetch_user(session[:user_id])
    else
      @current_user = nil
    end
  end

  def cookie_set
    if @user = current_user
      cookies[:user_id] = @user.id
    end
  end

  def fetch_user(id)
    return nil unless id
    User.find_by_id(id) || reset_session
  end

  def authenticate_user
    return if current_user
    flash[:alert] = "Sign up or Log in before continuing"
    redirect_to login_path
  end
end
