Rails.application.routes.draw do
  get 'session/index'

  get 'user/index'

  get 'tops/index'

  root 'tops#index'
   resources :pictures do
     collection do
       post :confirm
     end
  end
  resources :users do
    member do
      get "favorites" => "users#favorites"
    end
  end
  
  
    get 'sessions/new'
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
