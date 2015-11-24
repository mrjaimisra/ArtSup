Rails.application.routes.draw do
  root "welcome#index"

  get "/auth/amazon/callback", to: "sessions#create"

  get "/profile/:id", to: "users#show", as: :profile
  patch "/profile/:id", to: "users#update"
  get "/profile/:id/edit", to: "users#edit", as: :edit_profile

  get "/logout", to: "users#destroy", as: :logout

  get "/dashboard/:id", to: "dashboard#show", as: :dashboard

  resources :users, only: [:index]
  namespace :users, path: ":user" do
    resources :wishlists
  end
end
