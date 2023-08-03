class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index_public]

  def index
    @recipes = Recipe.includes(:user).where(user_id: current_user.id)
  end

  def show
    @recipe = Recipe.find(params[:id])
    return unless @recipe.public && @recipe.user != current_user

    redirect_to recipes_path, alert: 'You are not authorized to see this recipe.'
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to recipes_path(current_user.id), notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def destroy; end

  def public_recipe
    @public_recipes = Recipe.where(public: true)
    # @public_recipes = Recipe.includes(:user).where(public: true)
  end

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :preparation_time, :cooking_time, :description, :public)
  end

  # def set_current_user
  #   user = @current_user
  # end
end
