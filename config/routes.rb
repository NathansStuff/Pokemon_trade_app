Rails.application.routes.draw do
  resources :line_items
  resources :carts
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :items do
    resources :comments, module: :items
  end
  root 'items#index'
  get 'selling' => 'sellings#index'
  get 'charges/success' => 'charges#success'
  get 'sellings/home' => 'sellings#home'
  get 'sellings/sold' => 'sellings#sold'
  get "payments/success", to: "charges#success"
  post 'payments/webhook', to: 'charges#webhook'
  resources :conversations do
    resources :messages
  end
end
