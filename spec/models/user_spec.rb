require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(username: 'John Doe', email: 'tester@test.com', password: 'testing') }
  before { user.save }

  it 'name should be nil and not valid' do
    user.username = nil
    expect(user).to_not be_valid
  end

  it 'name should be a string' do
    expect(user.username).to be_a(String)
  end

  it 'user should be valid' do
    expect(user).to be_valid
  end

  it 'user should not be valid if no email' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'email should be valid' do
    expect(user.email).to be_a(String)
  end

  it 'user should be valid if no password' do
    user.password = nil
    expect(user).to be_valid
  end
end
