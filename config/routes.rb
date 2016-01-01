Rails.application.routes.draw do

  get 'admin/index', as: :admin

  controller :sessions do
    get 'login', to: :new
    post 'login', to: :create
    delete 'logout', to: :destroy
  end

  resources :users
  resources :orders
  resources :line_items
  resources :carts


  resources :products do
    get :who_bought, on: :member
  end

  root 'store#index', to: 'store#index', as: :store

end
