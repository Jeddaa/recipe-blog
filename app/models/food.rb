class Food < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :user_id
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods

  validates :food_name, :measurement_unit, presence: true
  validates :price, :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
