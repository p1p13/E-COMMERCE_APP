Rails.application.routes.draw do
  get 'welcome/index'
  get 'edit_profile', to: 'users#edit_profile' 
  patch 'update_profile', to: 'users#update_profile'
  resource :user do
    resources :shipping_details
  end
  resource :cart 
  resources :orders do
    resources :order_items
  end
  resources :products 
  post 'carts/add_to_cart'
  get  '/signup',  to: 'users#new'
  root 'welcome#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
