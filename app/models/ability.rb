class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Item, public: true
      if user.present?
        can :edit, Item, user_id: user.id
      end      
  end
  
end
