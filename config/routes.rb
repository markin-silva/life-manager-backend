Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/health", to: "health#index"

      mount_devise_token_auth_for "User", at: "auth"

      resources :categories, only: %i[index create update destroy]
      resources :transactions, only: %i[index show create update destroy]
      # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

      # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
      # Can be used by load balancers and uptime monitors to verify that the app is live.
      get "up" => "rails/health#show", as: :rails_health_check

      # Defines the root path route ("/")
      # root "posts#index"
    end
  end
end
