Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources  :users, defaults: {format: :json} do
        post 'creation', to:'users#create'
      end
    end
  end
end
