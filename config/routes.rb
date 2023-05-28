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
  #

  post '/eligibility', to: 'health_care_provider#check_eligibility'
  post '/send_pre_auth_request', to: 'health_care_provider#send_pre_auth_request'
  post '/health_care_provider', to: 'health_care_provider#update_docs_and_send_claim_request'
  # Defines the root path route ("/")
  # root "articles#index"
  #
  #
  post '/approve_consent', to: "consents#approve_consent"
end
