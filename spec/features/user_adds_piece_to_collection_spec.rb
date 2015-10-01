require 'rails_helper'

RSpec.feature "User adds a piece to the collection", type: :feature do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:amazon]
  end

  scenario "successfully" do

    login

    visit root_path
    click_link "Login"

    within(".g-tabs") do
      click_on "Collections"
    end

    expect(current_path).to eq(users_collections_path(2))

    click_link "Add A Collection"

    fill_in "Title", with: "Film Project"
    click_on "Create"

    expect(current_path).to eq(dashboard_path)

    click_on "Add Piece to Collection"

    expect(current_path).to eq(new_users_collection_piece_path(user: 2, collection_id: 2))

    fill_in "Name", with: "Short Film"
    click_on "Create"

    expect(current_path).to eq(dashboard_path)
  end
end
