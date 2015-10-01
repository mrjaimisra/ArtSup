require_relative '../../app/services/wishlist_service'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe 'WishlistService' do
  it 'parses my example wishlist' do
    VCR.use_cassette "artsup_wishlist" do
      items = WishlistService.fetch('579KNEDD72QR')
      expect(items[0]).to eq title:            "GoPro 3-Way Grip, Arm, Tripod",
                             price:            "59.99",
                             image_url:        "http://ecx.images-amazon.com/images/I/41AjJBDdt4L._SL500_SL135_.jpg",
                             quantity:         1,
                             asin:             "B00KCX8H6E",
                             registry_id:      "579KNEDD72QR",
                             product_group_id: "gl_camera",
                             registry_item_id: "I2HR6TWNIJ878Q",
                             merchant_id:      "ATVPDKIKX0DER"


      expect(items[1]).to eq title:            "Oumers Surfing Mouth Mount Water Sports, Accessories for Parachuting Swimming Rowing Surfing Skiing Climbing Running Diving Sports, For GoPro Hero HD, Hero 4 Silver Black, Hero 3+, Hero 3, Hero 2, Hero 1, GoPro Camera Accessories",
                             price:            "17.99",
                             image_url:        "http://ecx.images-amazon.com/images/I/51C0U9o8RHL._SL500_SL135_.jpg",
                             quantity:         1,
                             asin:             "B00ZTT4MFG",
                             registry_id:      "579KNEDD72QR",
                             product_group_id: "gl_camera",
                             registry_item_id: "I1WPVCCEDG5HN5",
                             merchant_id:      "A2EG1XSWJSILPK"

      expect(items.length).to eq 5
    end
  end
end
