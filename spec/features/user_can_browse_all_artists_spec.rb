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

    VCR.use_cassette "user_browse_artists_spec_wishlist" do
      click_link "Login with Amazon"
    end

    expect(current_path).to eq(dashboard_path(user.url))

    click_on "Browse Artists"

    expect(current_path).to eq(users_path)
    expect(page).to have_content(user.name)
  end
end
