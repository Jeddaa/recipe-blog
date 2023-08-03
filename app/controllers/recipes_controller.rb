class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index_public]

  def index
    @recipes = Recipe.includes(:user).where(user_id: current_user.id)
  end

  def show
    # if current_user.nil?
    #   User.find_by_id(params[:id])
    # @recipes = Recipe.includes(:user).where(user_id: user.id, public: true)
    # else
    @recipe = Recipe.find_by(id: params[:id])
    # end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
  end

  def public_recipe
    @public_recipes = Recipe.where(public: true)
    # @public_recipes = Recipe.includes(:user).where(public: true)
  end

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :preparation_time, :cooking_time, :description, :public)
  end
end
