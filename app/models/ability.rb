class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    case user.role
    when 'admin'
      can :manage, :all
      cannot :update, User, id: User.super_admin_id # Restrict altering super admin
    when 'doctor', 'receptionist'
      can :read, :dashboard
    end
  end
end
