class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :teams
  has_many :leagues, through: :teams, foreign_key: "commissioner_id"

  def has_team_in(league)
    league.teams.each do |team|
      if team.user_id == self.id
        return true
      end
    end
    false
  end
end
