require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.new(username: 'John Doe', email: "tester@test.com", password: "testing") }
  let(:food) do
    user.foods.build(food_name: "mashed potatoes", measurement_unit: "grams", price: 100, quantity: "20g")
  end

  before {food.save}

  it 'food should be valid' do
    expect(food).to be_valid
  end

  it 'food name should be a string' do
    expect(food.food_name).to be_a(String)
  end

  it 'food price should be an integer' do
    expect(food.price).to be_an(Integer)
  end

  # this spec has to be done this way
  it 'food should not be valid if price is a string' do
    food.price = "lkt"
    expect(food).to_not be_valid
    expect(food.errors[:price]).to include("is not a number")
  end

  it 'food should not be valid if no quantity' do
    food.quantity = nil
    expect(food).to_not be_valid
  end

  it 'food should not be valid if no price' do
    food.price = nil
    expect(food).to_not be_valid
  end
end
