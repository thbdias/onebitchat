class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :teams
  has_many :messages
  has_many :talks, dependent: :destroy
  has_many :team_users, dependent: :destroy
  has_many :member_teams, through: :team_users, :source => :team

  # self.teams -> times que o usuário criou
  # self.member_teams -> times que o usuário foi incluído
  # + -> exemplo: [1, 2, 3] + [4, 5] = [1, 2, 3, 4, 5]
  def my_teams
    self.teams + self.member_teams
  end

end
