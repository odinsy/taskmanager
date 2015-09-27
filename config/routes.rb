Rails.application.routes.draw do

  root 'main#index'
  # Registrations
  resources :registrations, only: [:new, :create]
  get '/sign_up', to: 'registrations#new', as: :sign_up
  # Sessions
  resources :sessions, only: [:new, :create, :destroy]
  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout
  # Projects
  resources :projects do
    collection do
      get :completed, only: [:index]
    end
    member do
      put :run
      put :complete
    end
  end
  #Tasks
  resources :tasks do
    collection do
      get :tomorrow, only: [:index]
      get :scheduled, only: [:index]
      get :waiting, only: [:index]
      get :completed, only: [:index]
    end
    member do
      put :run
      put :complete
    end
  end

end
