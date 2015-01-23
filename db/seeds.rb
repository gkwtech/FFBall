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
    if player.save
      puts player.first_name + player.last_name + " saved!"
    end
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

# drafted_league = League.create(name: "Drafted League", commissioner_id: users[0].id, member_amount: "8")
# drafted_league_teams = Team.create([
#   {name: "Patriots", user_id: users[0].id, league_id: drafted_league.id},
#   {name: "Bears", user_id: users[1].id, league_id: drafted_league.id},
#   {name: "Lions", user_id: users[2].id, league_id: drafted_league.id},
#   {name: "Eagles", user_id: users[3].id, league_id: drafted_league.id},
#   {name: "Chiefs", user_id: users[4].id, league_id: drafted_league.id},
#   {name: "Hawks", user_id: users[5].id, league_id: drafted_league.id},
#   {name: "Giants", user_id: users[6].id, league_id: drafted_league.id},
#   {name: "Pirates", user_id: users[7].id, league_id: drafted_league.id}])
# drafted_league_draft = Draft.create([
#   {year: DateTime.now.year, league_id: drafted_league.id}])
# total_picks = (drafted_league.teams.count * drafted_league.max_players)
# round_reset = drafted_league.teams.count
# round_number = 1
# pick_number = 1
# drafted_league_draft_round = drafted_league_draft.rounds.new(number: round_number)
# players = Player.all
# until total_picks == 0
#   if round_reset == 0
#     round_number += 1
#     drafted_league_draft_round = drafted_league_draft.rounds.new(number: round_number)
#   end
#   drafted_league_draft_round.picks.new(number: pick_number)
# end










