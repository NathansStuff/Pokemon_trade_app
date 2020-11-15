Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :items do
    resources :comments, module: :items
  end
  resource :charges
  root 'items#index'
  get 'selling' => 'sellings#index'
  get 'charges/success' => 'charges#success'
  get 'sellings/home' => 'sellings#home'
  get 'sellings/sold' => 'sellings#sold'
  resources :conversations do
    resources :messages
  end
end
