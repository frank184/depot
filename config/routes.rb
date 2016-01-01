Rails.application.routes.draw do
  root 'store#index', as: :store

  scope :admin do
    get "/", to: "admin#index", as: :admin
  end

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
end
