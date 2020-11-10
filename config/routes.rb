Rails.application.routes.draw do
  devise_for :users
  resources :items
  root 'items#index'
  get 'selling' => 'sellings#index'
end
