Rails.application.routes.draw do
  root "posts#index"

  # Static Pages
  get 'about', to: 'pages#about'
  get 'idea', to: 'pages#idea'

  resources :posts do
    resources :comments, only: [:create]
    member do
      put :upvote
    end
    collection do
      get 'add'
    end
  end
  resources :categories, only: [:show], path: '/'
  

end
