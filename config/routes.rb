Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :items do
    resources :comments, module: :items
  end
  root 'items#index'
  get 'selling' => 'sellings#index'
  get 'charges/success' => 'charges#success'
  get 'charges/new' => 'charges#new'
  get 'sellings/home' => 'sellings#home'
  get 'sellings/sold' => 'sellings#sold'
  get 'sellings/current' => 'sellings#current'
  get "payments/success", to: "charges#success"
  post 'payments/webhook', to: 'charges#webhook'
  resources :conversations do
    resources :messages
  end
 
end
