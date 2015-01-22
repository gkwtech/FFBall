class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :league
  has_many :players
  has_many :rosters

  validates :name, presence: true
  validates :user_id, presence: true
  validates :league_id, presence: true

  def standing
    league = self.league
    standings = league.teams.order("wins")
    place = standings.index(self)
    place += 1
    suffix = ""
    if place == 1
      suffix = "st"
    elsif place == 2
      suffix = "nd"
    elsif place == 3
      suffix = "rd"
    else
      suffix = "th"
    end
    return "#{place}#{suffix}"
  end
end
