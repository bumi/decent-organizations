Rails.application.routes.draw do
  root "posts#index"
  resources :posts do
    resources :comments, only: [:create]
    member do
      put :upvote
    end
    collection do
      get 'add'
    end
  end
  resources :categories, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
