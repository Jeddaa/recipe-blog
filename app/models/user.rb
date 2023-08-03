class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :foods
  has_many :recipes
  has_many :recipe_foods, through: :recipes

  validates :username, presence: true, uniqueness: true

  def recent_recipes
    recipes.order(created_at: :desc).limit(5)
  end
end
