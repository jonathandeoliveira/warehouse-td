Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: [:show, :create, :new, :edit, :update, :destroy] do
    resources :stock_product_destinations, only: [:create]
  end
  resources :suppliers, only: [ :index, :show, :create, :new, :edit, :update]
  resources :product_models, only: [:index, :create, :new, :show]
  resources :orders, only: [:new, :create, :show, :index, :edit, :update] do
    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member
    resources :order_items, only: [:new, :create]
  end




end
