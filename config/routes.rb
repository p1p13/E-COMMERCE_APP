Rails.application.routes.draw do
  get 'welcome/index'
  get 'edit_profile', to: 'users#edit_profile' 
  patch 'update_profile', to: 'users#update_profile'
  resources :users
  resources :shipping_details
  resources :cart 
  resources :orders
  resources :products 
  get  '/user',  to: 'users#profile'
  post 'carts/add_to_cart'
  get '/go_to_cart',  to: 'carts#go_to_cart'
  get  '/signup',  to: 'users#new'
  root 'welcome#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
