Rails.application.routes.draw do
  # get 'profile/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'profile#index'
  resources :posts
end
