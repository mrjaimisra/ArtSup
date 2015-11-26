class Wishlist < OpenStruct
  def self.fetch(wishlist_id)
    WishlistService.fetch(wishlist_id)
  end
end
