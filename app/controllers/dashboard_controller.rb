class DashboardController < ApplicationController
  before_action :authorize!

  def show
    @user = User.find_by(id: session[:user_id])
    @wishlist = get_wishlist(@user.wishlist_id)
  end

  private

    def get_wishlist(id)
      cache_store.fetch "wishlist_#{id}", expires_in: 1.hour do
        Wishlist.fetch(id)
      end
    end
end
