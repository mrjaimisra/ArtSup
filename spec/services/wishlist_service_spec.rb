require_relative '../../app/services/wishlist_service'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe 'WishlistService' do
  it 'parses my example wishlist' do
    VCR.use_cassette "artsup_wishlist" do
      items = WishlistService.fetch("579KNEDD72QR")
      expect(items[0]).to eq :title=>"Combat Sports Muay Thai Heavy Bag (100-Pound",
                             :link=>"http://amazon.com/dp/B006K3YL2Y?_encoding=UTF8&colid=579KNEDD72QR&coliid=I4V49W9E669Y7",
                             :price=>"149.99",
                             :image_url=>"http://ecx.images-amazon.com/images/I/31ot8BnISpL._SL500_SL135_.jpg",
                             :quantity=>1,
                             :asin=>"B006K3YL2Y",
                             :registry_id=>"579KNEDD72QR",
                             :product_group_id=>"gl_sports",
                             :registry_item_id=>"I4V49W9E669Y7",
                             :merchant_id=>"AKTIG9H3FIG6W"

      expect(items[1]).to eq :title=>"GoPro 3-Way Grip, Arm, Tripod",
                             :link=>"http://amazon.com/dp/B00KCX8H6E?_encoding=UTF8&colid=579KNEDD72QR&coliid=I2HR6TWNIJ878Q&psc=1",
                             :price=>"59.98",
                             :image_url=>"http://ecx.images-amazon.com/images/I/41AjJBDdt4L._SL500_SL135_.jpg",
                             :quantity=>1,
                             :asin=>"B00KCX8H6E",
                             :registry_id=>"579KNEDD72QR",
                             :product_group_id=>"gl_camera",
                             :registry_item_id=>"I2HR6TWNIJ878Q",
                             :merchant_id=>"ATVPDKIKX0DER"

      expect(items.length).to eq 5
    end
  end
end
