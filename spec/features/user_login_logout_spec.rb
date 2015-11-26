require 'rails_helper'
require_relative '../../app/services/wishlist_service'

RSpec.feature "User can login and logout", type: :feature do
  let!(:user) { User.find_or_create_from_auth_hash(login) }

  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:amazon]
  end

  scenario "successfully" do

    login
    visit root_path

    VCR.use_cassette "user_login_logout_spec_wishlist" do
      click_link "Login with Amazon"
    end

    expect(current_path).to eq(dashboard_path(user.url))

    visit root_path

    expect(current_path).to eq(dashboard_path(user.url))

    within(".navbar-collapse") do
      click_on "Logout"
    end

    expect(current_path).to eq(root_path)

    visit (dashboard_path(user.url))

    expect(current_path).to eq(root_path)
  end
end

