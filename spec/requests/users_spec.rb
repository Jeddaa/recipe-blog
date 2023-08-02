require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user =  User.create(username: 'John Doe', email: "tester@test.com", password: "testing")
    sign_in @user
  end

  describe 'GET /index' do
    it 'returns http success for users#show' do
      get users_path
      expect(response).to have_http_status(:success)
    end
  end
end
