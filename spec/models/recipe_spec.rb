require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.new(username: 'John Doe', email: 'tester@test.com', password: 'testing') }
  let(:recipe) do
    user.recipes.build(recipe_name: 'mashed potatoes', preparation_time: '1 hour', cooking_time: '1 hour 30 minutes',
                       description: 'Boil the potatoes till very soft then mash', public: true)
  end

  before { recipe.save }

  it 'should create a new recipe' do
    expect(recipe).to be_valid
  end

  it 'recipe should not be valid ' do
    recipe.recipe_name = nil
    expect(recipe).to_not be_valid
  end

  it 'recipe should not be valid ' do
    recipe.description = nil
    expect(recipe).to_not be_valid
  end

  it 'recipe should not be valid ' do
    recipe.cooking_time = nil
    expect(recipe).to_not be_valid
  end

  it 'recipe name should be a string ' do
    expect(recipe.recipe_name).to be_a(String)
  end

  it 'recipe preparation time should be a string ' do
    expect(recipe.preparation_time).to be_a(String)
  end

  it 'recipe cooking time should be a string ' do
    expect(recipe.cooking_time).to be_a(String)
  end

  it 'recipe description should be a string ' do
    expect(recipe.description).to be_a(String)
  end

  it 'recipe public field should be a boolean ' do
    expect(recipe.public).to be_a(TrueClass)
  end
end
