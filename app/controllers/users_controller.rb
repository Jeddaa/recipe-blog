class UsersController < ApplicationController
  def index
    # @users = User.all
    @users = User.includes(:recipes, :foods)
  end
end
