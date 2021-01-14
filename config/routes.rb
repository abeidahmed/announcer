Rails.application.routes.draw do
  resources :users, only: %i[create]
  resources :sessions, only: %i[create destroy]

  namespace :app do
    resource :account_setup, only: %i[new create]
  end
end
