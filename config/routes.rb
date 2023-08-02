Rails.application.routes.draw do
  devise_for :users
  # devise_for :users, controllers: { sessions: 'users/sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # resources :users



  resources :users
  resources :foods, only: [:index]

  resources :recipes, only: [:index, :show, :new, :create, :destroy, :public_recipe] do
    resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update]
  end

  get '/public_recipes', to: 'recipes#public_recipe', as: 'public_recipes'
  get '/shopping_list', to: 'shopping_list#index', as: 'general_shopping_list'

  root "foods#index"
  # root "recipes#index_public"

end
