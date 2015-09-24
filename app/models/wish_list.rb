class WishList < OpenStruct

  def self.service
    @service ||= WishListService.new
  end

  def self.all
    service.wish_list.map { |school| new(school) }
  end

  def self.find(id)
    WishList.new(service.wish_list(id))
  end

  def self.create(params)
    WishList.new(service.create_wish_list(params))
  end

  def self.update(id, params)
    service.update_wish_list(id, params)
  end
end
