class Ability
  include CanCan::Ability

  # roda quando se constroi uma classe
  # user -> current user
  def initialize(user)
    # se usuário existir
    if user
      # pode ler coisas do model Team 
      # se for dono do time ou membro do time
      can :read, Team do |t|
        t.user_id == user.id || t.users.where(id: user.id).present?
      end
      
      # se for dono do time
      can :destroy, Team, user_id: user.id

      # se for dono do time ou membro do time
      can [:read, :create], Channel do |c|
        c.team.user_id == user.id || c.team.users.where(id: user.id).present?
      end
      
      # se for dono do time ou dono do channel 
      can [:destroy, :update], Channel do |c|
        c.team.user_id == user.id || c.user_id == user.id
      end

      # se for um dos dois caras que está na conversa
      can [:read], Talk do |t|
        t.user_one_id == user.id || t.user_two_id == user.id
      end

      # so quem é dono do team 
      can [:create, :destroy], TeamUser do |t|
        t.team.user_id == user.id
      end
    end
  end
end
