class ShoppingListController < ApplicationController
  def index
    @foods = Food.with_quantity_deficiency(user: current_user)

    @quantity_delta = Food.quantity_delta(user: current_user)

    @prices = Food.calculate_prices(@quantity_delta)

    @total_price = @prices.values.sum
  end
end
