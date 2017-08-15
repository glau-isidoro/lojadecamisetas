Rails.application.routes.draw do
  root 'produtos#index'
  resources :produtos, only: [:new, :create, :destroy]

end
