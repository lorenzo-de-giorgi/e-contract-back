Rails.application.routes.draw do
  
  # Endpoint per registrazione (http://localhost:3000/api/v1/register)
  post '/api/v1/register', to: 'users#create'
  
  resources :users
  post '/auth/login', to: 'authentication#login'

end
