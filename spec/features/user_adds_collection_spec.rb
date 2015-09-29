require 'rails_helper'

RSpec.feature "User creates a new collection", type: :feature do

  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:amazon]
  end

  scenario "successfully" do

    login

    visit root_path
    click_link "Login"

    expect(current_path).to eq(dashboard_path)

    within(".g-tabs") do
      click_on "Collections"
    end

    expect(current_path).to eq(new_users_collection_path(1))

    fill_in "Title", with: "Film Project"
    fill_in "Description", with: "GoPro trip to the desert to film sand boarding"
    click_on "Create"

    expect(current_path).to eq(dashboard_path)
  end
end
