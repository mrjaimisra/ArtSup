require 'rails_helper'
require_relative '../../app/services/wishlist_service'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.feature "User can view his or her own wishlist", type: :feature do
let!(:user) { User.create(name: "Jai", email: "misrajai01@gmail.com")}


  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:amazon]
  end

  scenario "successfully" do

    login

    visit root_path
    click_link "Login"

    expect(current_path).to eq(dashboard_path)
    click_link "Wish List"

    expect(current_path).to eq(users_wishlist_path(1))
  end
end
