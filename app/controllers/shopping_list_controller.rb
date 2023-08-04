class ShoppingListController < ApplicationController
  def index
    @foods = current_user.foods
      .where('foods.quantity < (SELECT COALESCE(SUM(recipe_foods.quantity), 0)
    FROM recipe_foods WHERE recipe_foods.food_id = foods.id)')
      .references(:recipe_foods)

    @quantity_difference = current_user.foods
      .joins('LEFT JOIN recipe_foods ON recipe_foods.food_id = foods.id')
      .group('foods.id')
      .sum('COALESCE(recipe_foods.quantity, 0) - foods.quantity')

    @prices = {}

    @food_item = @foods.each do |food|
      price_per_food = food.price / food.quantity
      price = @quantity_difference[food.id] * price_per_food
      @prices[food.id] = price
    end

    @total_price = @foods.map do |food|
      @quantity_difference[food.id] * food.price
    end.sum
  end
end
