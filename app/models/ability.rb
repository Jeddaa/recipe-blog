class Ability
  include CanCan::Ability
  def initialize(user)
    can :read, Recipe, public: true

    # additional permissions for logged in users (they can read their own recipe)
    return unless user.present?

    can :read, :all
    can :manage, Recipe, user_id: user.id
    can :manage, RecipeFood, user_id: user.id
    can :manage, Food, user_id: user.id
  end
end
