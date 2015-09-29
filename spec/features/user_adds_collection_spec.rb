require 'rails_helper'

RSpec.feature "User creates a new collection", type: :feature do
  scenario "successfully" do
    visit root_path

    fill_in :title, with: "Film Project"
    fill_in :description, with: "GoPro trip to the desert to film sand boarding"
    click_on "Create"

    expect(current_path).to eq(users_collection_path(collection.id))
  end
end
