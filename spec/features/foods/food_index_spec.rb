require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  include Devise::Test::IntegrationHelpers
  before(:each) do
    @user = User.new(username: 'John Doe', email: 'tester@test.com', password: 'testing')
    sign_in @user
   @food1 = Food.create(food_name: "potatoes", measurement_unit: "grams", price: 100, quantity: 20, user: @user)
   @food2 = Food.create(food_name: "plantain", measurement_unit: "grams", price: 10, quantity: 2, user: @user)
  end

  describe 'recipes#index' do
    before(:each) do
      visit foods_path
    end

    it 'should show the recipe name of food1' do
      expect(page).to have_content(@food1.food_name)
    end

    it 'should show the recipe name of food1' do
      expect(page).to have_content(@food2.food_name)
    end

    it 'should show the description of food1' do
      expect(page).to have_content(@food1.measurement_unit)
    end

    it 'should show the description of food2' do
      expect(page).to have_content(@food2.price)
    end

    it 'should redirect to the show of food1 when clicked' do
      expect(page).to have_content('Measuring Unit')
    end

    it 'should redirect to the show of food1 when clicked' do
      expect(page).to have_content('Food')
    end
  end
end
