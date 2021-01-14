Rails.application.routes.draw do
  resources :users, only: %i[create destroy]
  resources :sessions, only: %i[create]
end
