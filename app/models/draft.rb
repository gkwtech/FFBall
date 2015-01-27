class Draft < ActiveRecord::Base
  has_many :rounds
  has_many :teams
  has_many :players
  belongs_to :league

  validates :league_id, presence: true

  def autorun
    picks = self.league.teams.count * self.league.max_players
    round_reset = self.league.teams.count - 1
    pick_number = 1
    round_number = 1
    round = Round.create(number: round_number, draft_id: self.id)
    players = Player.where(position: "QB")
    i = 0
    teams = self.league.teams
    until picks == 0
      if round_reset == -1
        round_number += 1
        pick_number = 1
        round = Round.create(number: round_number, draft_id: self.id )
        round_reset = self.league.teams.count - 1
      end
      if round.number > 9
        players = Player.where(position: "RB")
      elsif round.number > 4
        players = Player.where(position: "WR")
      elsif round.number > 2
        players = Player.where(position: "TE")
      end
      pick = round.picks.new(
        number: pick_number,
        price: 5,
        round_id: self.id,
        player_id: players[i].id,
        team_id: teams[round_reset].id
        )
      team_roster = teams[round_reset].rosters.new(
      player_id: pick.player_id,
      status: "member")
      if round.number == 1
        team_roster.position = "QB"
      elsif round.number == 3
        team_roster.position = "TE"
      elsif round.number == 5
        team_roster.position = "WR1"
      elsif round.number == 6
        team_roster.position = "WR2"
      elsif round.number == 10
        team_roster.position = "RB1"
      elsif round.number == 11
        team_roster.position = "RB2"
      elsif round.number == 12
        team_roster.position = "FLEX"
      else
        team_roster.position = "BN"
      end
      if pick.save && team_roster.save
        puts "Round #{round.number} | Pick #{pick.number} : #{Player.find(pick.player_id).first_name} #{Player.find(pick.player_id).last_name} - #{Team.find(pick.team_id).name}"
      end
      i += 1
      round_reset -= 1
      picks -=1
      pick_number += 1
    end
  end
end
