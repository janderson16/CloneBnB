Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :listings do
        get 'find_all', to: "finder#index"
        get 'most_visited', to: "visits#index"
      end
    end
  end
  root "home#index"
  get "dashboard", to: "dashboard#show"
  resources :codes, only: [:new, :create, :edit, :update]
  get 'reset_password', to: "codes#reset"
  patch 'reset_password', to: "codes#update_password"

  resources :listings, only: [:show, :index] do
    resources :reservations, only: [:new, :create]
  end
  resources :reservations, only: [:show]

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  put "update_host", to: "users#update"

  namespace :admin do
    get 'dashboard', to: "dashboard#show"
    resources :users, only: [:index, :update]
    resources :listings, only: [:index, :show, :destroy]
  end

  resources :users, only: [:new, :create, :edit, :update] do
    resources :reservations, only: [:index, :show, :new, :create, :update]
    resources :trips, only: [:index, :show]
    get 'listings', to: 'user/listings#index'
  end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :new, :create]
  end
end
