Rails.application.routes.draw do
  devise_for :users
  resources :products do
    member do
      post "/likes", to: "likes#create"
      delete "/likes", to: "likes#destroy"
      resources :reviews
    end
  end
  resources :checkouts
  concern :commentable do
    resources :comments
  end
  resources :comments, concerns: :commentable do
    member do
      post :reply
      post :cancel
    end
  end
  resources :blogs, concerns: :commentable do
    member do
      post "/vote", to: "votes#create"
    end
  end
  post "add_to_cart/", to: "carts#add"
  delete "remove_to_cart/", to: "carts#destroy"
  resources :imports
  resources :exports
  get "blogpet/", to: "dashboards#index"
  root "dashboards#index"
  # Sidekiq::Web.set :sessions, false
  mount Sidekiq::Web => "/sidekiq"
end