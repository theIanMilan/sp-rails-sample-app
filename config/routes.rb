Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      post 'sign_up', to: 'registrations#create'
    end
  end
end
