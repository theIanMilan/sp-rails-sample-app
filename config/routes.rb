Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    scope module: 'v1' do
      post 'sign_up', to: 'registrations#create'
      patch 'update', to: 'registrations#update'
      delete 'destroy', to: 'registrations#destroy'
      post 'sign_in', to: 'sessions#create'
      get 'validate_token', to: 'sessions#validate_token'
      delete 'sign_out', to: 'sessions#destroy'
    end
  end
end
