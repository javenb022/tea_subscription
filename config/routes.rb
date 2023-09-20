Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # post "/subscribe", to: "subscribe#create"
  post "/api/v1/user/:id/subscribe", to: "api/v1/subscribe#create"
end
