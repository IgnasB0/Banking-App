Rails.application.routes.draw do
  resources :deposits, only: [ :create ]
  resources :withdrawals, only: [ :create ]
  resources :transactions, only: [ :create ]
  resources :accounts, only: [ :index, :create, :show ]

  get "up" => "rails/health#show", as: :rails_health_check
end
