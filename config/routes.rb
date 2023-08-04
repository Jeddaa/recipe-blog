Rails.application.routes.draw do

  get '/public_recipes', to: 'recipes#public_recipe'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users

  resources :users
  resources :foods, only: [:index, :new, :create, :destroy]

  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update]
    member do
      get :toggle
    end
  end

  get '/general_shopping_list', to: 'shopping_list#index', as: 'general_shopping_list'

  root "foods#index"

end
