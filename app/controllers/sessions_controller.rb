class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(auth_hash)

    if user
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to root_path
    #   make a flash here
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
