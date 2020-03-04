Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'weather#show'

      get '/backgrounds', to: 'backgrounds#show'

      post '/users', to: 'users#create'

      post '/sessions', to: 'sessions#login'

      post '/road_trip', to: 'road_trips#create'
    end
  end
end
