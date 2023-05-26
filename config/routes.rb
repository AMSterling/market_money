Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :markets, only: %i[index show] do
        get '/vendors', to: 'market_vendors#index'
        get '/vendors/:vendor_id', to: 'market_vendors#show'
      end
      resources :vendors, only: %i[index show create update destroy] do
        get '/markets', to: 'vendor_markets#index'
        get '/markets/:market_id', to: 'vendor_markets#show'
      end
      post '/market_vendors', to: 'market_vendors#create'
      delete '/market_vendors', to: 'market_vendors#destroy'
    end
  end
end
