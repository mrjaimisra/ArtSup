# URL: http://www.justinscarpetti.com/projects/amazon-wish-lister/
# URL: https://github.com/doitlikejustin/amazon-wish-lister

amazon_id   = '579KNEDD72QR'
reveal      = 'reveal=unpurchased'
sort        = 'sort=date-added' # sorting options (date, title, price-high, price-low, updated, priority)
baseurl     = 'http://www.amazon.com'
page_number = 1 # realistically, there can be more than one
full_url    = "#{baseurl}/registry/wishlist/#{amazon_id}?#{reveal}&#{sort}&layout=standard&page=#{page_number}"
html_file   = "my_amazon_wishlist.html"

if File.exist? html_file
  html_string = File.read html_file
else
  require 'rest-client'
  html_string = RestClient.get full_url
  if html_string.code != 200
    binding.pry
  end
  File.write html_file, html_string.to_s
end


require 'json'
require 'nokogiri'
item_selector  = 'data-reg-item-inline-order'
document       = Nokogiri::HTML(html_string)
dom_items      = document.css("[#{item_selector}]")
raw_items_data = dom_items.map { |dom_item| JSON.parse dom_item[item_selector] }

item_data = raw_items_data.map do |data|
  { price:            data["price"], # <-- :D
    asin:             data["asin"],
    sid:              data['sid'],
    registry_id:      data['registryId'],
    offer_id:         data["offerId"],
    product_group_id: data["productGroupId"],
    quantity:         data["quantity"],
    registry_item_id: data["registryItemId"],
    merchant_id:      data["merchantId"],
    registry_subtype: data["registrySubType"],
    registry_type:    data["registryType"],
    is_gift:          data["isGift"],
  }
end
