Rails.application.routes.draw do
  get 'profile/:id' => 'profile#index', as: :profile, constraints: { id: /[0-9]+/ }
  get 'users/index'
  get 'users/friend_requests'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :comments
  resources :friendships, only: [:create, :destroy, :update]
  resources :likes, only: [:create, :destroy]
  resources :posts, only: [:create, :index]
  unauthenticated do
    as :user do 
      root to: 'users/registrations#new'
    end
  end
  root to: 'posts#index'
end
