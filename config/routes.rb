Rails.application.routes.draw do
  devise_for :users
  get 'session/index'

  get 'user/index'

  get 'tops/index'
  
   resources :places do
     collection do
       get "categories" => "places#categories"
       post :confirm
     end
  end

  root 'tops#index'
  
  resources :users do
    member do
      get "favorites" => "users#favorites"
    end
  end
  
  get "/sessions/new" => redirect('/users/sign_in')
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
