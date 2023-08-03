Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users
  resources :foods, only: [:index, :new, :create, :destroy]  

  resources :recipes, only: [:index, :show, :new, :create, :destroy, :public_recipe] do
    resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update]
  end

  # get '/shopping_list', to: 'shopping_list#index', as: 'shopping_list'
  get '/general_shopping_list', to: 'shopping_list#index', as: 'general_shopping_list'
  get '/public_recipes', to: 'recipes#public_recipe'

  root "foods#index"
  # root "recipes#index_public"

end

