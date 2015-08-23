Rails.application.routes.draw do
  root 'main#index'

  resources :tasks do
    collection do
      get 'tomorrow', only: [:index]
      get 'scheduled', only: [:index]
      get 'waiting', only: [:index]
    end
  end
end
