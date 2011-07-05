class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :login_from_session
  
  def logged_in?
    !!current_user
  end
  
  def current_user
    @current_user
  end
  
  def login_as(user)
    @current_user = user
    session[:current_user_id] = user.try(:id)
  end

  def login_from_session
    @current_user = User.find_by_id(session[:current_user_id])
  end
end
