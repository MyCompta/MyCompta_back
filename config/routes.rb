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

    resources :users
  end
  get 'up' => 'rails/health#show', as: :rails_health_check

end
