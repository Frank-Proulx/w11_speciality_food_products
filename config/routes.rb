Rails.application.routes.draw do
  devise_for :users
  root to: 'products#landing'
  resources :products do
    resources :reviews
  end
end
