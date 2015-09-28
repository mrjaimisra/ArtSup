require_relative '../../app/services/wishlist_service'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe 'WishlistService' do
  it 'parses my example wishlist' do
    VCR.use_cassette "artsup_wishlist" do
      items = WishlistService.import('579KNEDD72QR')

      expect(items[0]).to eq registry_item_id: "I25TX5TV56UHJF",
                             price:            "39.99",
                             asin:             "B00XAR64M8",
                             registry_id:      "579KNEDD72QR",
                             offer_id:         "IzDLxvnf1pMnGzmsz2ltjP%2BjFnN2OmKbfd5C6cMgS4UlGDjnmHYtWQqXbyByQcMPJRIjI8qboEupcmKxkZ8ZGfBPXGJYqN7eG3ol57HfO%2FUy1nJYHbmQoGUXPqpPtnSt8m2ZD5%2F9GVvy3nmGLtNI7lkym4GgRkXt",
                             product_group_id: "gl_camera",
                             quantity:         1,
                             merchant_id:      "A3EXDMG8FUV8V2"

      expect(items[1]).to eq registry_item_id: "I25TX5TV56UHJF",
                             registry_item_id: "I94YZ16MDP5UL",
                             price:            "29.95",
                             asin:             "B000LQLDM2",
                             registry_id:      "579KNEDD72QR",
                             offer_id:         "9XViaP2gcFQGo%2BoRk%2ByQl0mrFB1%2BxjPdvzAkmkA0K48faZaRmQndn8eOq1JNM3wZaSk5D5Gq71mxJzc%2BUavBC4jz1JOyiSmoqFVK3ttmFVc%3D",
                             product_group_id: "gl_musical_instruments",
                             quantity:         1,
                             merchant_id:      "ATVPDKIKX0DER"

      expect(items.length).to eq 2
    end
  end
end
