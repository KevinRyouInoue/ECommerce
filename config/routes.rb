Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Root path
  root "products#index"
  
  # Products
  resources :products, only: [:index, :show]
  
  # Cart
  get 'cart', to: 'cart#index', as: 'cart_index'
  post 'cart/add/:product_id', to: 'cart#add_item', as: 'add_to_cart'
  delete 'cart/remove/:id', to: 'cart#remove_item', as: 'remove_from_cart'
  patch 'cart/update/:id', to: 'cart#update_quantity', as: 'update_cart_quantity'
  
  # Orders
  resources :orders, only: [:index, :show, :new, :create]
  
  # Authentication
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'logout', to: 'sessions#destroy'
  
  # User registration
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
end
