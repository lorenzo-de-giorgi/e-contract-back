Rails.application.routes.draw do
  
  # Endpoint per registrazione (http://localhost:3000/api/v1/register)
  namespace :api do
    namespace :v1 do
      post '/register', to: 'users#create'
      post '/login', to: 'authentication#login'
    end
  end
end
