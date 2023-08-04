require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before(:each) do
    @user = User.create(username: 'John Doe', email: 'tester@test.com', password: 'testing')
    @recipe = Recipe.create(recipe_name: 'mashed potatoes', preparation_time: '1 hour', user_id: @user.id, public: true,
                            description: 'Boil the potatoes til very soft then mash', cooking_time: '1 hour 30 minutes')
    @food = Food.create(food_name: 'mashed potatoes', measurement_unit: 'grams', price: 100, quantity: 20,
                        user_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 20, recipe_id: @recipe.id, food_id: @food.id)
  end

  it 'should be valid' do
    expect(@recipe_food).to be_valid
  end

  it 'should not be valid if recipe_id is nil' do
    @recipe_food.recipe_id = nil
    expect(@recipe_food).to_not be_valid
  end

  it 'should not be valid if food_id is nil' do
    @recipe_food.food_id = nil
    expect(@recipe_food).to_not be_valid
  end

  it 'should not be valid if recipe_id is not int' do
    @recipe_food.recipe_id = 'a'
    expect(@recipe_food).to_not be_valid
  end

  it 'should not be valid if food_id is not int' do
    @recipe_food.food_id = 'lkt'
    expect(@recipe_food).to_not be_valid
  end

  it 'should be valid' do
    expect(@recipe_food.food).to eq(@food)
  end

  it 'should be valid' do
    expect(@recipe_food.recipe).to eq(@recipe)
  end
end
