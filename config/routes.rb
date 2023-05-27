Rails.application.routes.draw do
  resources :consents
  resources :claim_status_histories
  resources :notifications
  resources :claims
  resources :health_reports
  resources :prescriptions
  resources :insurance_policies
  resources :invoices
  resources :people
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
