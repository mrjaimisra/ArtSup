class ConfirmController < ApplicationController
  protect_from_forgery except: :show

  respond_to :html, :js

  def show
    @user = User.find_by(url: params["url"])
    @title = params["title"]
    @price = params["price"]
    @quantity = params["quantity"]
    @image = params["image"]
  end

  def create
  end
end
