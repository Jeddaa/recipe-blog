class ChangeQuantityColumnTypeInFoods < ActiveRecord::Migration[7.0]
  def change
    change_column :foods, :quantity, :integer, using: 'quantity::integer'
  end
end
