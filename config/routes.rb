Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      post 'sign_up', to: 'registrations#create'
      delete 'destroy', to: 'registrations#destroy'
    end
  end
end
