Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"
  resources :products
  resources :checkouts
  resources :carts, only: [:index]
  get "add_to_cart/", to: "carts#add"
  delete "remove_to_cart/", to: "carts#destroy"
end
