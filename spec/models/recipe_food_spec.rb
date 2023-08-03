require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.new(username: 'John Doe', email: 'tester@test.com', password: 'testing') }
  let(:recipe) do
    user.recipes.build(recipe_name: 'mashed potatoes', preparation_time: '1 hour', cooking_time: '1 hour 30 minutes',
                       description: 'Boil the potatoes till very soft then mash', public: true)
  end
  let(:food) do
    user.foods.build(food_name: 'mashed potatoes', measurement_unit: 'grams', price: 100, quantity: '20g')
  end
  let(:recipe_food) { RecipeFood.create(quantity: '20g', recipe:, food:) }

  before { recipe_food.save }

  it 'should be valid' do
    expect(recipe_food).to be_valid
  end

  it 'should not be valid if recipe_id is nil' do
    recipe_food.recipe_id = nil
    expect(recipe_food).to_not be_valid
  end

  it 'should not be valid if food_id is nil' do
    recipe_food.food_id = nil
    expect(recipe_food).to_not be_valid
  end

  it 'should not be valid if recipe_id is not int' do
    recipe_food.recipe_id = 'a'
    expect(recipe_food).to_not be_valid
  end

  it 'should not be valid if food_id is not int' do
    recipe_food.food_id = 'lkt'
    expect(recipe_food).to_not be_valid
  end

  it 'should be valid' do
    expect(recipe_food.food).to eq(food)
  end

  it 'should be valid' do
    expect(recipe_food.recipe).to eq(recipe)
  end
end
