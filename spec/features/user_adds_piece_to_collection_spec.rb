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
    fill_in "Description", with: "GoPro trip to the desert to film sand boarding"
    click_on "Create"

    expect(current_path).to eq(dashboard_path)

    click_on "Add Piece to Collection"

    expect(current_path).to eq(new_users_collection_piece_path(user: 2, collection_id: 2))

    fill_in "Name", with: "Short Film"
    fill_in "Description", with: "A little footage"
    # attach_file "Image", "./app/assets/images/street-art-portrait-1500x1000.jpg"
    click_on "Create"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Short Film")
    expect(page).to_not have_content("A little footage")

    # expect(page).to have_css(".current-collection-images")
  end
end
