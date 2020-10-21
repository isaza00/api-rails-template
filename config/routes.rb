Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "login", to: "users#login"
      resources :users, param: :user_id

    end
  end
end
