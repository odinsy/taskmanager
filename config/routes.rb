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
    resources :subtasks, only: [:new, :create], controller: :tasks
    collection do
      get :tomorrow,  controller: :task_schedules
      get :scheduled, controller: :task_schedules
      get :waiting,   controller: :task_schedules
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
