Rails.application.routes.draw do
  resources :users, only: %i[new create]
  resources :sessions, only: %i[new create destroy]

  namespace :app do
    resource :account_setup, only: %i[new create]
    resources :projects, only: %i[index]
  end
end
