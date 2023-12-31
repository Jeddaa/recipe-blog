class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  load_and_authorize_resource :recipe

  def index
    @recipe_foods = RecipeFood.include(:user).where(user_id: current_user.id)
  end

  def show
    @recipe_food = RecipeFood.find(params[:id])
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.create(recipe_food_params)

    if @recipe_food.save
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])

    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(@recipe_food.recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_path
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:recipe_id, :food_id, :quantity)
  end
end
