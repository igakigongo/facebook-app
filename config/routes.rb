Rails.application.routes.draw do
  # match 'profile/:id'
  get 'profile/:id' => 'profile#index', as: :profile, constraints: { id: /[0-9]+/ }
  get 'users/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :comments
  resources :likes, only: [:create, :destroy]
  resources :posts, only: [:create, :index]
  unauthenticated do
    as :user do 
      root to: 'users/registrations#new'
    end
  end
  root to: 'posts#index'
end
