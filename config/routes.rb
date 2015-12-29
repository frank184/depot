Rails.application.routes.draw do
  resources :users
  resources :orders
  resources :line_items
  resources :carts

  get 'store/index', to: 'store#index', as: :store

  resources :products do
    get :who_bought, on: :member
  end

  root 'store#index'

end
