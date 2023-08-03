Rails.application.routes.draw do
  devise_for :users

  resources :users
  resources :foods, only: [:index, :new, :create, :destroy]  

  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update]
  end

  # get '/shopping_list', to: 'shopping_list#index', as: 'shopping_list'
  get '/general_shopping_list', to: 'shopping_list#index', as: 'general_shopping_list'
  get '/public_recipes', to: 'recipes#public_recipe'

  root "foods#index"

end

