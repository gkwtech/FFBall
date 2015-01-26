class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :league
  has_many :players, through: :rosters
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

  def position_check(player)
    self.rosters.each do |roster|
      if roster.status == "member" && roster.position == player.position
        return "filled"
      end
    end
    "vacant"
  end

  def set_position(player, roster)
    if self.position_check(player) == "vacant"
      roster.position = player.position
    else
      roster.position = "BN"
    end
  end

  def active_roster_count
    i = 0
    self.rosters.each do |player|
      if player.status == "member"
        i += 1
      end
    end
    return i
  end

  def active_roster
    players = []
    self.rosters.each do |player|
      if player.status == "member"
        players << Player.find(player.player_id)
      end
    end
    return players
  end

  def project_lineup
    positions = {
      QB: "Empty",
      RB1: "Empty",
      RB2: "Empty",
      WR1: "Empty",
      WR2: "Empty",
      TE: "Empty",
      FLEX: "Empty"
    }
    i = 1
    rosters = self.active_roster
    rosters.each do |player|
      if player.position == "QB" && positions[:QB] == "Empty"
        positions[:QB] = player
      elsif player.position == "RB" && positions[:RB1] == "Empty"
        positions[:RB1] = player
      elsif player.position == "RB" && positions[:RB2] == "Empty"
        positions[:RB2] = player
      elsif player.position == "WR" && positions[:WR1] == "Empty"
        positions[:WR1] = player
      elsif player.position == "WR" && positions[:WR2] == "Empty"
        positions[:WR2] = player
      elsif player.position == "TE" && positions[:TE] == "Empty"
        positions[:TE] = player
      elsif positions[:FLEX] == "Empty"
        positions[:FLEX] = player
      else
        bench_position = ("BN#{i}").to_sym
        positions[bench_position] = player
        i += 1
      end
    end
    positions
  end
end
