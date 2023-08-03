require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  include Devise::Test::IntegrationHelpers
  before(:each) do
    @user = User.new(username: 'John Doe', email: 'tester@test.com', password: 'testing')
    sign_in @user
    @recipe1 = Recipe.create(user: @user, recipe_name: 'mashed potatoes', preparation_time: '1 hour',
                             cooking_time: '1 hour 30 minutes', public: true,
                             description: 'Boil the potatoes till very soft then mash')
    @recipe2 = Recipe.create(user: @user, recipe_name: 'rice and peas', preparation_time: '30 mins',
                             cooking_time: '1 hour', description: 'boil the rice and peas till soft',
                             public: false)
  end

  describe 'recipes#index' do
    before(:each) do
      visit recipes_path
    end

    it 'should show the recipe name of recipe1' do
      expect(page).to have_content(@recipe1.recipe_name)
    end

    it 'should show the recipe name of recipe1' do
      expect(page).to have_content(@recipe2.recipe_name)
    end

    it 'should show the description of recipe1' do
      expect(page).to have_content(@recipe1.description)
    end

    it 'should show the description of recipe2' do
      expect(page).to have_content(@recipe2.description)
    end

    it 'should redirect to the show of recipe1 when clicked' do
      visit recipe_path(@recipe1)
      expect(page).to have_content('Preparation time')
    end

    it 'should redirect to the show of recipe1 when clicked' do
      visit recipe_path(@recipe2)
      expect(page).to have_content('boil the rice and peas till soft')
    end
  end
end
