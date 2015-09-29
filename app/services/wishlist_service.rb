require "uri"
require "net/http"
require "json"
require "nokogiri"

module WishlistService
  def self.fetch(amazon_id)
    html = request amazon_id: amazon_id, base_url: 'http://www.amazon.com', page_number: 1
    parse(html)
  end

  def self.request(amazon_id:, base_url:, page_number:)
    raw_uri  = "#{base_url}/registry/wishlist/#{amazon_id}?reveal=unpurchased&sort=date-added&layout=standard&page=#{page_number}"
    uri      = URI.parse raw_uri
    http     = Net::HTTP.new uri.host, uri.port
    request  = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    if response.code != '200'
      binding.pry
    end

    response.body
  end

  def self.parse(html)
    item_selector  = 'data-reg-item-inline-order'
    document       = Nokogiri::HTML(html)
    dom_items      = document.css("[#{item_selector}]")
    dom_items.map do |dom_item|
      data = JSON.parse dom_item[item_selector]
      { title:            document.at_css("#itemImage_#{data['registryItemId']} a")['title'],
        price:            data["price"], # <-- :D
        image_url:        document.at_css("#itemImage_#{data['registryItemId']} a").at_css('img')['src'],
        quantity:         data["quantity"],
        asin:             data["asin"],
        registry_id:      data["registryId"],
        product_group_id: data["productGroupId"],
        registry_item_id: data["registryItemId"],
        merchant_id:      data["merchantId"]
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
