require 'rails_helper'
require_relative '../../app/services/wishlist_service'

RSpec.feature "User can create and delete a new wishlist", type: :feature do
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

    fill_in "Wishlist url", with: "https://amzn.com/w/579KNEDD72QR"

    VCR.use_cassette "user_creates_wishlist" do
      click_on "Submit"
    end

    expect(current_path).to eq(users_wishlist_path(user: user.id,
                                                   id: current_path.split('/').last))

    expect(page).to have_content("#{user.name}'s Wishlist")

    VCR.use_cassette "user_deletes_wishlist" do
      click_on "Delete Wishlist"
    end

    expect(current_path).to eq(new_users_wishlist_path(user))
  end
end
