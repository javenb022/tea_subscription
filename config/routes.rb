Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # post "/subscribe", to: "subscribe#create"
  get "/api/v1/users/:user_id/subscriptions", to: "api/v1/subscription#index"
  post "/api/v1/user/:id/subscribe", to: "api/v1/subscription#create"
  patch "/api/v1/users/:id/unsubscribe", to: "api/v1/unsubscribe#update"
end
