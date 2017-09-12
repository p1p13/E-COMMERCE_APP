Rails.application.routes.draw do
  get 'sessions/new'

  get 'welcome/index'
  resources :users do
    resources :shipping_details
    resource :cart do
      resources :cart_items
    end
  end
  resources :products
  get 'users/new'
  get  '/signup',  to: 'users#new'
  root 'welcome#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
