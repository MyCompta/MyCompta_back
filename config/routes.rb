# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: {
      sessions: 'api/users/sessions',
      registrations: 'api/users/registrations'
    }

    resources :societies
    resources :clients
    resources :invoices
    get 'quotations/:id', to: 'invoices#quotation_show'
    resources :registers


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

        get 'sum_by_country_ordered_alphabet'
      
        
      end
    end


    resources :users
  end
  get 'up' => 'rails/health#show', as: :rails_health_check

end
