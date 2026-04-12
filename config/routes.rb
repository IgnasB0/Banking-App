Rails.application.routes.draw do
  resource :session
resources :deposits, only: [ :create ]
  resources :withdrawals, only: [ :create ]
  resources :transactions, only: [ :new, :create ]
  resources :accounts, only: [ :index, :create, :show ]

  root "accounts#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
