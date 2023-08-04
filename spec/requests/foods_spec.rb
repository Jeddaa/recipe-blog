require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  # let(:user) { User.new(username: 'John Doe', email: "tester@test.com", password: "testing") }
  # let(:food) do
  #   @food = user.foods.build(food_name: "mashed potatoes", measurement_unit: "grams", price: 100, quantity: "20g")
  # end

  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(username: 'John Doe', email: 'tester@test.com', password: 'testing')
    sign_in @user
    @food = Food.create(food_name: 'potatoes', measurement_unit: 'grams', price: 100, quantity: 20, user: @user)
  end

  describe 'GET /food' do
    it 'returns http success for foods#index' do
      get foods_path
      expect(response).to have_http_status(:success)
    end

    it 'render correct foods#index' do
      get foods_path
      expect(response).to render_template(:index)
    end

    it 'renders the correct placeholder for foods#index' do
      get foods_path
      expect(response.body).to include('potatoes')
    end

    it 'renders the correct placeholder for food#show' do
      get foods_path
      expect(response.body).to include('grams')
    end
  end

  describe 'POST' do
    before(:each) do
      food_param = { food_name: 'pineapple', measurement_unit: 'grams', price: 50, quantity: 50, user: @user }
      post foods_path, params: { food: food_param }
    end
    it 'creates a new food' do
      expect(response.status).to eq(302)
    end

    it 'food name should be pineapple' do
      expect(Food.last.food_name).to eq('pineapple')
    end

    it 'food count should be 2' do
      expect(Food.count).to eq(2)
    end

    it 'food price should be 50' do
      expect(Food.last.price).to eq(50)
    end
    it 'food measurement unit should be grams' do
      expect(Food.first.measurement_unit).to eq('grams')
    end
  end
end
