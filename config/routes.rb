Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # resources :users

  # root "recipes#index_public"
  authenticated :user do
    root 'recipes#index', as: :authenticated_root
  end

  unauthenticated do
    root 'recipes#index_public', as: :unauthenticated_root
  end
  resources :users, only: [:index, :show] do
    resources :recipes, only: [:new, :create, :show, :index_public, :index, :destroy]
    resources :foods, only: [:new, :show, :index, :create, :destroy] do
      resources :recipe_foods, only: [:new, :create]
    end
  end
end
