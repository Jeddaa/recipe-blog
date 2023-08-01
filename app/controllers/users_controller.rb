class UsersController < ApplicationController
  def index
    @users = User.includes(:recipes, :foods)
  end
end
