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
      expect(items[0]).to eq title:            "STUNTMAN G - Shoulder, Chest and Hip Mount for GoPro Cameras",
                             price:            "39.99",
                             image_url:        "http://ecx.images-amazon.com/images/I/41IO-4Pbq%2BL._SL500_SL135_.jpg",
                             quantity:         1,
                             asin:             "B00XAR64M8",
                             registry_id:      "579KNEDD72QR",
                             offer_id:         "IzDLxvnf1pMnGzmsz2ltjP%2BjFnN2OmKbfd5C6cMgS4UlGDjnmHYtWQqXbyByQcMPJRIjI8qboEupcmKxkZ8ZGfBPXGJYqN7eG3ol57HfO%2FUy1nJYHbmQoGUXPqpPtnSt8m2ZD5%2F9GVvy3nmGLtNI7lkym4GgRkXt",
                             product_group_id: "gl_camera",
                             registry_item_id: "I25TX5TV56UHJF",
                             merchant_id:      "A3EXDMG8FUV8V2"


      expect(items[1]).to eq title:            "Samson SP01 Spider Shockmount",
                             price:            "29.95",
                             image_url:        "http://ecx.images-amazon.com/images/I/41Fcruy73aL._SL500_SL135_.jpg",
                             quantity:         1,
                             asin:             "B000LQLDM2",
                             registry_id:      "579KNEDD72QR",
                             offer_id:         "9XViaP2gcFQGo%2BoRk%2ByQl0mrFB1%2BxjPdvzAkmkA0K48faZaRmQndn8eOq1JNM3wZaSk5D5Gq71mxJzc%2BUavBC4jz1JOyiSmoqFVK3ttmFVc%3D",
                             product_group_id: "gl_musical_instruments",
                             registry_item_id: "I94YZ16MDP5UL",
                             merchant_id:      "ATVPDKIKX0DER"

      expect(items.length).to eq 2
    end
  end
end
