require 'rails_helper'
require_relative '../../app/services/wishlist_service'

RSpec.feature "User confirms order spec", type: :feature do
  let!(:user) { User.find_or_create_from_auth_hash(login) }

  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:amazon]
  end

  scenario "successfully" do
    wishlist_item = { :title => "Combat Sports Muay Thai Heavy Bag (100-Pound",
                      :link => "http://amazon.com/dp/B006K3YL2Y?_encoding=UTF8&colid=579KNEDD72QR&coliid=I4V49W9E669Y7",
                      :price => "99.99",
                      :image_url => "http://ecx.images-amazon.com/images/I/31ot8BnISpL._SL500_SL135_.jpg",
                      :quantity => 1,
                      :asin => "B006K3YL2Y",
                      :registry_id => "579KNEDD72QR",
                      :product_group_id => "gl_sports",
                      :registry_item_id => "I4V49W9E669Y7",
                      :merchant_id => "AKTIG9H3FIG6W" }

    login

    visit root_path

    VCR.use_cassette "user_order_spec_wishlist" do
      click_link "Login with Amazon"
    end

    expect(current_path).to eq(dashboard_path(user.url))
    click_link "Wish List"

    expect(current_path).to eq(new_users_wishlist_path(user))

    fill_in "Wishlist url", with: "https://amzn.com/w/579KNEDD72QR"

    VCR.use_cassette "user_creates_wishlist_for_order_spec" do
      click_on "Submit"
    end

    expect(current_path).to eq(users_wishlist_path(user: user.id,
                                                   id: current_path.split('/').last))

    expect(page).to have_content("#{user.name}'s Wishlist")

    within(".dropdown-menu") do
      click_on "Dashboard"
    end

    first('a', "Buy from Amazon.com").click

    visit "/confirm/#{wishlist_item[:asin]}?asin=#{wishlist_item[:asin]}&title=#{wishlist_item[:title]}&price=#{wishlist_item[:price]}&quantity=#{wishlist_item[:quantity]}&image=#{wishlist_item[:image]}&url=#{user.url}"

    click_on "Confirm your supporter gift"

    expect(current_path).to eq(notification_path(user.url))

    click_on "Send Email"

    expect(current_path).to eq(dashboard_path(user.url))
  end
end
