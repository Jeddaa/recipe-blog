require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(username: 'John Doe', email: 'tester@test.com', password: 'testing')
    sign_in @user
    @recipe = Recipe.create(user: @user, recipe_name: 'mashed potatoes', preparation_time: '1 hour',
                            cooking_time: '1 hour 30 minutes', public: true,
                            description: 'Boil the potatoes till very soft then mash')
  end

  describe 'GET' do
    it 'returns http success for recipe#index' do
      get recipes_path
      expect(response).to have_http_status(:success)
    end

    it 'render correct recipe#index' do
      get recipes_path
      expect(response).to render_template(:index)
    end

    it 'render correct recipe#index' do
      get recipe_path(@recipe.id)
      expect(response).to render_template(:show)
    end

    it 'renders the correct placeholder for recipes#index' do
      get recipes_path
      expect(response.body).to include('mashed potatoes')
    end

    it 'renders the correct placeholder for recipes#show' do
      get recipe_path(@recipe.id)
      expect(response.body).to include('1 hour')
    end
  end

  describe 'POST' do
    it 'creates a new recipe' do
      recipe_param = { recipe_name: 'rice and peas', preparation_time: '30 mins', cooking_time: '1 hour',
                       description: 'boil the rice and peas till soft' }
      post recipes_path, params: { recipe: recipe_param }
      expect(response).to have_http_status(:success)
      expect(Recipe.count).to eq(1)
    end
  end
end
