require 'vacuum'
require 'json'
require 'nokogiri'

request = Vacuum.new

request.configure(
    aws_access_key_id: "",
    aws_secret_access_key: "",
    associate_tag: 'art0e2-20'
)

response = request.item_lookup(
    query: {
        'ItemId' => 'B00XAR64M8'
    }
)

#
# response = request.cart_create(
#     query: {
#         'HMAC' => 'secret',
#         'Item.1.OfferListingId' => 'IVG4667EUA5H9',
#         'Item.1.Quantity' => 1
#     }
# )

p response

class MyParser
  # A parser has to respond to this.
  def self.parse(body)
    new(body)
  end

  def initialize(body)
    @body = body
  end

  def self.objectify(html)
    document       = Nokogiri::HTML(html)
    data = JSON .parse(html)
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

require 'pry'; binding.pry
document = Nokogiri::HTML.parse(response.body)
p document

