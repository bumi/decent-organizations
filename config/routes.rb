Rails.application.routes.draw do
  root "posts#index"
  resources :posts do
    resources :comments, only: [:create]
    member do
      put :upvote
    end
  end
  resources :categories, only: [:show]
  
  # Static Pages
  get 'pages/about'
  get 'pages/idea'
end
