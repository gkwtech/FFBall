# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Dir.foreach('nflgame/nflgame/gamecenter-json') do |file|
#   next if file == '.' or file == '..' or file == '.DS_Store'
#   gamedate = file
#   file = File.open("nflgame/nflgame/gamecenter-json/#{file}")
#   file = JSON.parse(file.read)
#   binding.pry
#   gamedate = gamedate.match(/\d+/).to_s
#   drives = []
#   binding.pry
#   drives << file[gamedate]["drives"]
#   drive_ids = []
#   drives.each do |drive|
#     drive_ids << drive.keys
#   end
#   plays = []
#   drive_ids.each do |id|
#     plays << drives[id]["plays"]
#   end
#   binding.pry
# end

file = File.open("players.json")
file = JSON.parse(file.read)
file.each do |player|
  unless player[1]["birthdate"].nil?
    birthday = player[1]["birthdate"]
    birthday = birthday.split("/")
    proper_birthday = []
    proper_birthday << birthday[2]
    proper_birthday << birthday[0]
    proper_birthday << birthday[1]
    birthday = proper_birthday.join("-")
    player = Player.new(
      first_name: player[1]["first_name"],
      last_name: player[1]["last_name"],
      gsis_id: player[1]["gsis_id"],
      height: player[1]["height"],
      weight: player[1]["weight"],
      years_pro: player[1]["years_pro"],
      position: player[1]["position"],
      birthdate: birthday)
    player.save
  end
end

users = User.create([
  {email: "a@a.com", password: "password"},
  {email: "b@b.com", password: "password"},
  {email: "c@c.com", password: "password"},
  {email: "d@d.com", password: "password"},
  {email: "e@e.com", password: "password"},
  {email: "f@f.com", password: "password"},
  {email: "g@g.com", password: "password"},
  {email: "h@h.com", password: "password"}])
league = League.create(name: "Fake League", commissioner_id: users[0].id, member_amount: "8")
teams = Team.create([
  {name: "Cowboys", user_id: users[0].id, league_id: league.id},
  {name: "Bears", user_id: users[1].id, league_id: league.id},
  {name: "Lions", user_id: users[2].id, league_id: league.id},
  {name: "Eagles", user_id: users[3].id, league_id: league.id},
  {name: "Chiefs", user_id: users[4].id, league_id: league.id},
  {name: "Hawks", user_id: users[5].id, league_id: league.id},
  {name: "Giants", user_id: users[6].id, league_id: league.id},
  {name: "Pirates", user_id: users[7].id, league_id: league.id}])
drafted_league = League.create(name: "Drafted League", commissioner_id: users[0].id, member_amount: "8")
drafted_league_teams = Team.create([
  {name: "Patriots", user_id: users[0].id, league_id: drafted_league.id},
  {name: "Bears", user_id: users[1].id, league_id: drafted_league.id},
  {name: "Lions", user_id: users[2].id, league_id: drafted_league.id},
  {name: "Eagles", user_id: users[3].id, league_id: drafted_league.id},
  {name: "Chiefs", user_id: users[4].id, league_id: drafted_league.id},
  {name: "Hawks", user_id: users[5].id, league_id: drafted_league.id},
  {name: "Giants", user_id: users[6].id, league_id: drafted_league.id},
  {name: "Pirates", user_id: users[7].id, league_id: drafted_league.id}])
drafted_league_draft = Draft.create(year: 2015, league_id: drafted_league.id)
total_picks = (drafted_league.teams.count * drafted_league.max_players)
round_reset = drafted_league.teams.count - 1
round_number = 1
pick_number = 1
drafted_league_draft_round = Round.create(number: round_number, draft_id: drafted_league_draft.id)
players = Player.where(position: "QB")
i = 0
until total_picks == 0
  if round_reset == -1
    round_number += 1
    pick_number = 1
    drafted_league_draft_round = Round.create(number: round_number, draft_id: drafted_league_draft.id )
    round_reset = drafted_league.teams.count - 1
  end
  if drafted_league_draft_round.number > 9
    players = Player.where(position: "RB")
  elsif drafted_league_draft_round.number > 4
    players = Player.where(position: "WR")
  elsif drafted_league_draft_round.number > 2
    players = Player.where(position: "TE")
  end
  pick = drafted_league_draft_round.picks.new(
    number: pick_number,
    price: 5,
    round_id: drafted_league_draft_round.id,
    player_id: players[i].id,
    team_id: drafted_league_teams[round_reset].id
    )
  team_roster = drafted_league_teams[round_reset].rosters.new(
      player_id: pick.player_id,
      status: "member")
  if drafted_league_draft_round.number == 1
    team_roster.position = "QB"
  elsif drafted_league_draft_round.number == 3
    team_roster.position = "TE"
  elsif drafted_league_draft_round.number == 5
    team_roster.position = "WR1"
  elsif drafted_league_draft_round.number == 6
    team_roster.position = "WR2"
  elsif drafted_league_draft_round.number == 10
    team_roster.position = "RB1"
  elsif drafted_league_draft_round.number == 11
    team_roster.position = "RB2"
  elsif drafted_league_draft_round.number == 12
    team_roster.position = "FLEX"
  else
    team_roster.position = "BN"
  end
  if pick.save && team_roster.save
    puts "Round #{drafted_league_draft_round.number} | Pick #{pick.number} : #{Player.find(pick.player_id).first_name} #{Player.find(pick.player_id).last_name} - #{Team.find(pick.team_id).name}"
  end
  i += 1
  round_reset -= 1
  total_picks -=1
  pick_number += 1
end










