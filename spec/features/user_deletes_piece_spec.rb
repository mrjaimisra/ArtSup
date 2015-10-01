require 'rails_helper'

RSpec.feature "User deletes piece from collection", type: :feature do

  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:amazon]
  end

  scenario "successfully" do

    login

    visit root_path
    click_link "Login"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_link("Add A Collection")

    within(".g-tabs") do
      click_on "Collections"
    end

    expect(current_path).to eq(users_collections_path(4))

    click_link "Add A Collection"

    expect(current_path).to eq(new_users_collection_path(4))

    fill_in "Title", with: "Film Project"
    fill_in "Description", with: "GoPro trip to the desert to film sand boarding"
    click_on "Create"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Film Project")
    expect(page).to have_content("GoPro trip to the desert to film sand boarding")


    within(".g-tabs") do
      click_on "Collections"
    end

    expect(current_path).to eq(users_collections_path(4))
    expect(page).to have_content("Film Project")
    expect(page).to have_content("GoPro trip to the desert to film sand boarding")

    click_link "Add A Collection"

    expect(current_path).to eq(new_users_collection_path(4))

    fill_in "Title", with: "Art Project"
    fill_in "Description", with: "My second collection"
    click_on "Create"

    expect(current_path).to eq(dashboard_path)

    within(".g-tabs") do
      click_on "Collections"
    end

    expect(current_path).to eq(users_collections_path(4))
    expect(page).to have_content("Film Project")
    expect(page).to have_content("GoPro trip to the desert to film sand boarding")
    expect(page).to have_content("Art Project")
    expect(page).to have_content("My second collection")
  end
end
