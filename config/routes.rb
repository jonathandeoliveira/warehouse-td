Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: [:show, :create, :new, :edit, :update, :destroy]
  resources :suppliers, only: [ :index, :show, :create, :new, :edit, :update]
  resources :product_models, only: [:index, :create, :new, :show]
end
