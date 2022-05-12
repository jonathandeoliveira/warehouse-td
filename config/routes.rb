Rails.application.routes.draw do
  root to: 'home#index'
  resources :warehouses, only: [:show, :create, :new, :edit, :update, :destroy]
  resources :suppliers, only: [ :index, :show, :create, :new, :edit, :update]
end
