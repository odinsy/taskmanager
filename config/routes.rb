Rails.application.routes.draw do

  root 'main#index'

  resources :registrations, only: [:new, :create]
  get '/sign_up', to: 'registrations#new', as: :sign_up

  resources :sessions, only: [:new, :create, :destroy]
  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout

  resources :profile, only: [:edit, :show, :update]

  resources :tasks do
    resources :subtasks, only: [:new, :create], controller: :tasks
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

  resources :projects do
    collection do
      get :completed, only: [:index]
    end
    member do
      put :run
      put :complete
    end
    resources :tasks, only: [:new, :create, :destroy], shallow: true
  end

end
