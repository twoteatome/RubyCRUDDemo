Rails.application.routes.draw do
  mount API => '/'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get     "login"    => "sessions#new"
  post    "login"    => "sessions#create"
  get     "logout"   => "sessions#destroy"
  post    "buy"      => "products#buy"
  get     "buy"      => "products#buy"

  resources :products
  resources :users
  resources :orders
  root 'products#index'

  
end
