Rails.application.routes.draw do
  scope '(:locale)' do
    root 'store#index', as: :store
    get 'contact/index', as: :contact
    get 'news/index', as: :news
    get 'questions/index', as: :questions

    scope :admin do
      get "/", to: "admin#index", as: :admin
    end

    controller :sessions do
      get 'login', to: :new
      post 'login', to: :create
      delete 'logout', to: :destroy
    end


    resources :products do
      get :who_bought, on: :member
    end

    resources :users
    resources :orders
    resources :line_items
    resources :carts
  end
end
