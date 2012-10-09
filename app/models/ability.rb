class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    cannot :manage, Entity
    can :create, Entity

    can :manage, :all if user.role? :admin

    can :manage, Entity do |entity|
      entity.user?(user) || entity.roles_include?(user.roles)
    end
  end

end
