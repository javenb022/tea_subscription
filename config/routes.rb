Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # post "/subscribe", to: "subscribe#create"
  namespace :api do
    namespace :v1 do
      resources :subscribe, only: [:create]
    end
  end
end
