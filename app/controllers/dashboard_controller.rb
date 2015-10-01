class DashboardController < ApplicationController
  before_action :authorize!

  def show
    @user = User.find_by(id: session[:user_id])
  end
end
