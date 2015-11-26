require 'rails_helper'
require_relative '../../app/services/wishlist_service'

RSpec.feature "User confirms order spec", type: :feature do
  let!(:user) { User.find_or_create_from_auth_hash(login) }

  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:amazon]
  end

  scenario "successfully" do
    login

    visit root_path

    VCR.use_cassette "user_profile_spec_wishlist" do
      click_link "Login with Amazon"
    end

    expect(current_path).to eq(dashboard_path(user.url))

    click_on "Click here to add address information to your profile"

    fill_in "Street address", with: "123 Street"
    fill_in "City", with: "Devner"
    fill_in "State", with: "CO"
    fill_in "Story", with: "lalala"
    fill_in "Gift", with: "Boom"

    click_on "Save"

    expect(current_path).to eq(profile_path(user.url))

    expect(page).to have_content("123 Street")
    expect(page).to have_content("Devner")
    expect(page).to have_content("CO")
    expect(page).to have_content("lalala")
    expect(page).to have_content("Boom")
  end
end
