class Ability
  include CanCan::Ability
  def initialize(user)
    # can :read, Recipe, public: true
    return unless recipe.public == true
    can :read, Recipe, public: true

    # additional permissions for logged in users (they can read their own recipe)
    return unless user.present?

    can(:read, Recipe, user:)
    can :destroy, Recipe.where(user_id: user.id)

    # can(:read, Comment, user:)
    # can :destroy, Comment.where(author_id: user.id)


    # can :manage, :all
    # can :destroy, Post
    # can :destroy, Comment
  end
end

