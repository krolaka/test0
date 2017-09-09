class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      cannot [:new, :create, :update, :destroy, :edit], :User
      can [:index, :show, :list], :User
    end
  end
end
