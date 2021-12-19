Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :users, only: %i[index show] do
    resources :friendships
  end

  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end

  namespace :api do
    namespace :v1, default: { format: :json } do
      resources :users
      resources :posts, only: %i[index create] do
        resources :comments, only: %i[index create]
      end

      post '/sign_in', to: 'sessions#create', as: 'user_sign_in'
      delete '/sign_out', to: 'sessions#destroy', as: 'user_sign_out'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
