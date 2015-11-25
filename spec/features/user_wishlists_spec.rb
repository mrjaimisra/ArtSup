require 'rails_helper'
require_relative '../../app/services/wishlist_service'
# require 'vcr'

# VCR.configure do |config|
#   config.cassette_library_dir = "fixtures/vcr_cassettes"
#   config.hook_into :webmock
# end


RSpec.feature "User can view his or her own wishlist", type: :feature do
  let!(:user) { User.find_or_create_from_auth_hash(login) }

  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:amazon]
  end

  scenario "successfully" do
    login

    visit root_path

    VCR.use_cassette "user_wishlist_spec_wishlist" do
      click_link "Login with Amazon"
    end

    expect(current_path).to eq(dashboard_path(user.url))
    click_link "Wish List"

    expect(current_path).to eq(new_users_wishlist_path(user))
  end
end
