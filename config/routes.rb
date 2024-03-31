# frozen_string_literal: true

Rails.application.routes.draw do
  resources :registers
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: {
      sessions: 'api/users/sessions',
      registrations: 'api/users/registrations'
    }

    resources :societies
    resources :clients
    resources :invoices
    get 'quotations/:id', to: 'invoices#quotation_show'

    
    resources :charts do
      collection do
        get 'sum_all_client'
        get 'sum_all_society'
        get 'transformed'
        get 'notransformed'
        get 'invoice_paid'
        get 'invoice_not_paid'

        get 'sum_all_client_by_society'                       #charts/sum_all_client_by_society?society_id=10
        get 'sum_all_sub_total_by_client_by_society'          #/charts/sum_all_sub_total_by_client_by_society?society_id=10
        get 'sum_all_tva_by_client_by_society'                #/charts/sum_all_tva_by_client_by_society?society_id=10
      
        
      end
    end

    resources :registers


    resources :users
  end

  # scope :api, defaults: { format: :json } do
  #   devise_for :users, controllers: {
  #     sessions: 'api/users/sessions',
  #     registrations: 'registrations'
  #   }
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
