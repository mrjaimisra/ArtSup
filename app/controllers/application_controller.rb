class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_collection

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Why is this the current collection?
  def current_collection
    @current_collection ||= current_user.collections.last
  end

  def authorize!
    redirect_to root_path unless current_user
  end
end
