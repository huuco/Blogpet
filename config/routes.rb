Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "products#index"
  resources :products do
    member do
      post "/likes", to: "likes#create"
      delete "/likes", to: "likes#destroy"
      # resources :comments, only: [:create]
      resources :reviews
    end
  end
  resources :checkouts
  resources :comments do
    resources :comments
  end
  resources :blogs do
    resources :comments do
      member do
        get :reply
      end
    end
    member do
      post "/vote", to: "votes#create"
    end
  end
  post "add_to_cart/", to: "carts#add"
  delete "remove_to_cart/", to: "carts#destroy"
  resources :imports
  get "blogpet/", to: "dashboards#index"
  root "dashboards#index"
end
