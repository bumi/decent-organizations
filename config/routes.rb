Rails.application.routes.draw do
  root "posts#index"
  resources :posts
  resources :categories, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
