class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :recipe_name, :preparation_time, :cooking_time, :description, presence: true
  validates :public, inclusion: { in: [true, false] }
end
