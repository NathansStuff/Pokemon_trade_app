Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :items do
    resources :comments, module: :items
  end
  resource :charges
  root 'items#index'
  get 'selling' => 'sellings#index'

end
