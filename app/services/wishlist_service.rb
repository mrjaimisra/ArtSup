require "uri"
require "net/http"
require "json"
require "nokogiri"

module WishlistService
  def self.fetch(amazon_id)
    html = request amazon_id: amazon_id, base_url: 'http://www.amazon.com', page_number: 1
    parse(html)
  end

  def self.request(info = {amazon_id: "", base_url: "", page_number: ""})
    raw_uri  = "#{info[:base_url]}/registry/wishlist/#{info[:amazon_id]}?reveal=unpurchased&sort=date-added&layout=standard&page=#{info[:page_number]}"
    uri      = URI.parse raw_uri
    http     = Net::HTTP.new uri.host, uri.port
    request  = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    if response.code != '200'
      # binding.pry
    end

    response.body
  end

  def self.parse(html)
    item_selector  = "data-reg-item-inline-order"
    document       = Nokogiri::HTML(html)
    dom_items      = document.css("[#{item_selector}]")
    dom_items.map do |dom_item|
      data = JSON.parse dom_item[item_selector]
      { title:            document.at_css("#itemImage_#{data['registryItemId']} a")['title'],
        link:             'http://amazon.com' + document.at_css("#itemName_#{data['registryItemId']}")['href'],
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
