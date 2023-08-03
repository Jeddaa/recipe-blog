class Food < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :user_id

  def self.with_quantity_deficiency(user:)
    includes(:user)
      .where('foods.quantity < (SELECT COALESCE(SUM(recipe_foods.quantity), 0)
        FROM recipe_foods WHERE recipe_foods.food_id = foods.id)')
      .where(user_id: user.id)
      .references(:recipe_foods)
  end

  def self.quantity_delta(user:)
    joins('LEFT JOIN recipe_foods ON recipe_foods.food_id = foods.id')
      .group('foods.id')
      .where(user_id: user.id)
      .sum('COALESCE(recipe_foods.quantity, 0) - foods.quantity')
  end

  def self.calculate_prices(quantity_delta)
    prices = {}

    Food.find(quantity_delta.keys).each do |ingredient|
      price_per_ingredient = if ingredient.quantity.zero?
                               ingredient.price
                             else
                               ingredient.price / ingredient.quantity
                             end

      price = quantity_delta[ingredient.id] * price_per_ingredient
      prices[ingredient.id] = price
    end

    prices
  end
end
