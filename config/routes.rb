Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      post '/market_vendors', to: 'market_vendors#create'
      delete '/market_vendors', to: 'market_vendors#destroy'

      resources :markets, only: %i[index show] do
        get '/vendors', to: 'markets/vendors#index'
        get '/vendors/:vendor_id', to: 'markets/vendors#show'
      end

      resources :vendors, only: %i[index show create update destroy] do
        get '/markets', to: 'vendor_markets#index'
        get '/markets/:market_id', to: 'vendor_markets#show'
      end
    end
  end
end
