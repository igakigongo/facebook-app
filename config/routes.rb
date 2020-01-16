Rails.application.routes.draw do
  get 'users/index'
  # get 'profile/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'profile#index'
  resources :comments
  resources :likes, only: [:create, :destroy]
  resources :posts
end
