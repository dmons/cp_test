Rails.application.routes.draw do
  namespace :admin do
    resources :tickets, only: [:index, :edit, :update, :destroy]
  end
  resources :main, only: [:index, :new, :create]
  resource :session

  # Defines the root path route ("/")
  root "main#index"
end
