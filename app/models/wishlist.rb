class Wishlist < OpenStruct

  def self.service
    @service ||= WishlistService.new
  end

  def self.all
    # self.service.wish_list.map { |item| new(item) }
  end

  def self.find(id)
    Wishlist.new(service.wish_list(id))
  end

  def self.fetch(wishlist_id)
    WishlistService.fetch(wishlist_id)
  end

  def self.update(id, params)
    service.update_wish_list(id, params)
  end
end
