class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @recipes = Recipe.includes(:user).where(user_id: current_user.id)
  end

  def show
    @recipes = Recipe.find_by(id: params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      puts 'saved recipe'
      redirect_to user_recipes_path(current_user.id), notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def destroy
  end

  def index_public
    @recipes = Recipe.where(public: true)
  end

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :preparation_time, :cooking_time, :description, :public)
  end

  # def set_current_user
  #   user = @current_user
  # end
end
