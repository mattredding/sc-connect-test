module ApplicationHelper
  def current_user
    @current_user
  end

  def logged_in?
    !!current_user
  end
end
