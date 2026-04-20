Rails.application.routes.draw do
  resource :session
  resources :deposits, only: %i[create]
  resources :withdrawals, only: %i[create]
  resources :transfers, only: %i[new create index]
  resources :accounts, only: %i[index create show]

  root "accounts#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
