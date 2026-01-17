Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :animals, only: [ :index ]
  resources :user_animals, only: [ :create, :index ]

  get "/auth/:provider/callback", to: "sessions#create"
  get "/api/current_user", to: "sessions#show"
  get "/logout", to: "sessions#destroy"
  delete "/logout", to: "sessions#destroy"

  namespace :api do
    get "github/contributions", to: "githubs#contributions"
    resource :notification_setting, only: [:show, :create, :update]
  end
end
