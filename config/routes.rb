Rails.application.routes.draw do

  root 'main#index'

  get :completed, controller: :states

  resources :registrations, only: [:new, :create]
  get '/sign_up', to: 'registrations#new', as: :sign_up

  resources :profile, only: [:edit, :show, :update]

  resources :sessions, only: [:new, :create, :destroy]
  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout

  resources :tasks do
    resources :subtasks, only: [:create, :destroy], shallow: true do
      member do
        put :run
        put :complete
      end
    end
    collection do
      get :tomorrow
      get :scheduled
      get :waiting
    end
    member do
      put :run
      put :complete
    end
  end

  resources :projects do
    member do
      put :run
      put :complete
    end
    resources :tasks, only: [:new, :create, :destroy], shallow: true
  end

end
