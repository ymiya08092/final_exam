Rails.application.routes.draw do
  get 'session/index'

  get 'user/index'

  get 'tops/index'

  root 'tops#index'
   resources :blogs do
    collection do
      post :confirm
    end
  end
  
    get 'sessions/new'
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
