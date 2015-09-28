require "uri"
require "net/http"
require 'json'
require 'nokogiri'

module WishlistService
  def self.import(amazon_id)
    reveal      = 'reveal=unpurchased'
    sort        = 'sort=date-added' # sorting options (date, title, price-high, price-low, updated, priority)
    baseurl     = 'http://www.amazon.com'
    page_number = 1 # realistically, there can be more than one
    full_url    = "#{baseurl}/registry/wishlist/#{amazon_id}?#{reveal}&#{sort}&layout=standard&page=#{page_number}"


    uri      = URI.parse full_url
    http     = Net::HTTP.new uri.host, uri.port
    request  = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    if response.code != '200'
      binding.pry
    end

    item_selector  = 'data-reg-item-inline-order'
    document       = Nokogiri::HTML(response.body)
    dom_items      = document.css("[#{item_selector}]")
    dom_items.map do |dom_item|
      data = JSON.parse dom_item[item_selector]
      { price:            data["price"], # <-- :D
        asin:             data["asin"],
        registry_id:      data['registryId'],
        offer_id:         data["offerId"],
        product_group_id: data["productGroupId"],
        quantity:         data["quantity"],
        registry_item_id: data["registryItemId"],
        merchant_id:      data["merchantId"],
        # sid:              data['sid'],
        # registry_subtype: data["registrySubType"],
        # registry_type:    data["registryType"],
        # is_gift:          data["isGift"],
      }
    end
  end
end

__END__
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
