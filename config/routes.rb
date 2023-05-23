Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :markets, only: %i[index show] do
        get '/vendors', to: 'market_vendors#index'
      end
      resources :vendors, only: %i[index show] do

      end
    end
  end
end
