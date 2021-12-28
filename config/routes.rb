Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: [:show] do 
    resources :reservations, only: [:index]
  end

  resources :nfts do 
    resources :reservations, only: [:create]
  end

  resources :reservations, only: [:edit, :update, :destroy]
end
