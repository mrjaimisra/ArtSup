Rails.application.routes.draw do
  root "welcome#index"

  get "/auth/amazon/callback", to: "sessions#create"

  get "/profile/:url", to: "users#show", as: :profile
  patch "/profile/:url", to: "users#update"
  get "/profile/:url/edit", to: "users#edit", as: :edit_profile

  get "/logout", to: "sessions#destroy", as: :logout

  get "/dashboard/:id", to: "dashboard#show", as: :dashboard

  resources :users, only: [:index]
  namespace :users, path: ":user" do
    resources :wishlists
    resources :galleries
  end

  get "confirm/:asin", to: "confirm#show"
  post "confirm/:asin", to: "confirm#create"

  resources :notifications, only: [:create, :show]
end
