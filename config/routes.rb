Rails.application.routes.draw do
  get 'welcome/index'
  
  resources :users do
    collection do
      get '/edit_profile', to: 'users#edit_profile' 
      get  '/profile',  to: 'users#profile'
      patch '/update_profile', to: 'users#update_profile'
      get  '/signup',  to: 'users#new'

    end
  end
  resources :shipping_details
  resources :cart do
    collection do
       get '/go_to_cart',  to: 'carts#go_to_cart'
       post '/add_to_cart', to: 'carts#add_to_cart'
    end
  end
  resources :orders
  resources :products 
  resources :sessions, only: [] do
    collection do
      get    '/login',   to: 'sessions#new'
      post   '/login',   to: 'sessions#create'
      delete '/logout',  to: 'sessions#destroy'
    end
  end

  root 'welcome#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
