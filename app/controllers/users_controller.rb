class UsersController < ApplicationController
  def index
    @users = User.includes(:recipes, :foods)
  end

  def show
    # @user = User.find_by(id: params[:id])
    # if request.format.symbol == :html
    #   redirect_to root_path
    # else
    #   head :no_content
    # end
  end
end
