Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :markets, only: %i[index]
    end
  end
end
