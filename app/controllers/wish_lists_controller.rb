class WishListsController < ApplicationController
  def create
    @wish_list = WishList.create(params)

    redirect_to school_path(@school.id)
  end

  def index
    @wish_list = WishList.find(params[:id])
  end
end
