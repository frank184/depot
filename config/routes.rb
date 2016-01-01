Rails.application.routes.draw do
  root 'store#index', as: :store

  controller :sessions do
    get 'login', to: :new
    post 'login', to: :create
    delete 'logout', to: :destroy
  end

  resources :admin
  resources :users
  resources :orders
  resources :line_items
  resources :carts
  resources :products do
    get :who_bought, on: :member
  end
end
