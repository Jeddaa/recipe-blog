require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  include Devise::Test::IntegrationHelpers
  before(:each) do
    @user = User.new(username: 'John Doe', email: 'tester@test.com', password: 'testing')
    sign_in @user
    @recipe1 = Recipe.create(recipe_name: 'mashed potatoes', preparation_time: '1 hour',
                             description: 'Boil the potatoes till very soft then mash', public: true,
                             user: @user, cooking_time: '1 hour 30 minutes')
    @recipe2 = Recipe.create(user: @user, recipe_name: 'rice and peas', preparation_time: '30 mins',
                             cooking_time: '1 hour', description: 'boil the rice and peas till soft',
                             public: false)
  end

  describe 'recipes#index' do
    before(:each) do
      visit recipe_path(@recipe1)
    end

    it 'should show the id of recipe 1' do
      expect(page).to have_content(@recipe1.id)
    end

    it 'should show the recipe name of recipe1' do
      expect(page).to have_content(@recipe1.recipe_name)
    end

    it 'should show the prepartion time of recipe1' do
      expect(page).to have_content(@recipe1.preparation_time)
    end

    it 'should show the cooking time of recipe2' do
      expect(page).to have_content(@recipe2.cooking_time)
    end

    it 'should have generate shopping list' do
      expect(page).to have_content('Generate shopping list')
    end

    it 'should redirect to the create new recipe page' do
      visit new_recipe_path(@user)
      expect(page).to have_content('Create a New Recipe')
    end
  end
end
