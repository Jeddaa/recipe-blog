class FoodsController < ApplicationController
  def index
    @all_foods = Food.includes(:user).where(user_id: current_user.id)
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.create(food_params)
    if @food.save
      redirect_to foods_path
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity).merge(user_id: current_user.id)
  end
end