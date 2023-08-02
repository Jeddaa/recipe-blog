Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users
  resources :foods, only: [:index, :new]

  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    resources :recipe_foods, only: [:new, :create, :destroy, :edit]
  end

  get '/public_recipes', to: 'recipes#public_recipe', as: 'public_recipes'
  get '/general_shopping_list', to: 'shopping_list#index', as: 'general_shopping_list'

  root "foods#index"

end
