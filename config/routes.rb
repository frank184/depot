Rails.application.routes.draw do
  resources :line_items
  resources :carts

  get 'store/index', to: 'store#index', as: :store

  resources :products

  root 'store#index'

end
