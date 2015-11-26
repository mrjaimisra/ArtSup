require 'rails_helper'
require_relative '../../app/services/wishlist_service'

RSpec.feature "User can add and edit current work", type: :feature do
  let!(:user) { User.find_or_create_from_auth_hash(login) }

  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:amazon]
  end

  scenario "successfully" do
    login

    visit root_path

    VCR.use_cassette "user_edit_work_spec_wishlist" do
      click_link "Login with Amazon"
    end

    expect(current_path).to eq(dashboard_path(user.url))

    click_on "Upload a picture here"

    expect(current_path).to eq(new_users_gallery_path(user.url))

    fill_in "Description", with: "D"
    click_on "Upload"

    expect(page).to have_content("D")
    expect(current_path).to eq(dashboard_path(user.url))

    click_on "Edit your picture"

    fill_in "Description", with: "J"
    click_on "Upload"

    expect(page).to have_content("J")
    expect(current_path).to eq(dashboard_path(user.url))
  end

  scenario "unsuccessfully without a description" do
    login

    visit root_path

    VCR.use_cassette "user_edit_work_unsuccessfully_spec_wishlist" do
      click_link "Login with Amazon"
    end

    expect(current_path).to eq(dashboard_path(user.url))

    click_on "Upload a picture here"

    expect(current_path).to eq(new_users_gallery_path(user.url))

    fill_in "Description", with: ""
    click_on "Upload"

    expect(current_path).to eq(users_galleries_path(user.url))

    fill_in "Description", with: "D"
    click_on "Upload"

    expect(current_path).to eq(dashboard_path(user.url))
    expect(page).to have_content("D")
  end
end
