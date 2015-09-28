# $baseurl = 'http://www.amazon.com';
# $content = phpQuery::newDocumentFile("$baseurl/registry/wishlist/$amazon_id?$reveal&$sort&layout=standard");


require 'open-uri'

class WishlistService
  attr_reader :connection

  def initialize
    @connection = Hurley::Client.new("http://www.justinscarpetti.com/projects/amazon-wish-lister/api/")
  end

  def wish_list(id)
    params = { id: id }
    parse(connection.get("", params)).map do |item|
      binding.pry
      page                = Nokogiri::HTML(open(item[:link]))
      price               = page.search("#priceblock_ourprice").first.children.to_s
      asin                = page.search("#ASIN").first.attributes["value"].value
      item[:price]        = price
      item[:asin]         = asin
      item[:wish_list_id]   = id
      item
    end
  end

  def create_wish_list(params)
    parse(connection.get("", params))
  end

  # def update_wish_list(id, params)
  #   connection.put("wish_list/#{id}", params)
  # end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
