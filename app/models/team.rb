class Team < ApplicationRecord
  belongs_to :user
  has_many :talks, dependent: :destroy
  has_many :channels, dependent: :destroy
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  validates_presence_of :slug, :user
  validates :slug, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  before_save :general_channel

  def general_channel
    self.channels << Channel.create(slug: 'general', user_id: self.user.id)
  end

  # self.users -> usuário que são membros desse time -> retorna um array
  # self.user -> dono desse time -> retorna um registro
  # + -> exemplo: [1, 2, 3] + [4, 5] = [1, 2, 3, 4, 5]
  # [self.user] -> mudando um registro para um array com um registro, para que possa ser 'somado' com o primeiro array
  def my_users
    self.users + [self.user]
  end
end
