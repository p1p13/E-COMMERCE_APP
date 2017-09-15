Rails.application.routes.draw do
  get 'welcome/index'
  resource :user do
    resources :shipping_details
  end
  resource :cart do
    resources :cart_items
  end

  resources :orders do
    resources :order_items
  end
  resources :products
  get 'cart_items/new'
  get  '/signup',  to: 'users#new'
  root 'welcome#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
