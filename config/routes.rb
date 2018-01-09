Rails.application.routes.draw do
  root 'tops#index'
   resources :blogs do
    collection do
      post :confirm
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
