Rails.application.routes.draw do
  root 'home#index'

  resources :users

  get "/signin", to: "users/sessions#new", as: "signin"
  post "/signin", to: "users/sessions#create"
  delete "/signout", to: "users/sessions#destroy", as: "signout"
end
