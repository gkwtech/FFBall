# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Dir.foreach('nflgame/nflgame/gamecenter-json') do |file|
  next if file == '.' or file == '..' or file == '.DS_Store'
  gamedate = file
  file = File.open("nflgame/nflgame/gamecenter-json/#{file}")
  file = JSON.parse(file.read)
  binding.pry
  gamedate = gamedate.match(/\d+/).to_s
  drives = []
  binding.pry
  drives << file[gamedate]["drives"]
  drive_ids = []
  drives.each do |drive|
    drive_ids << drive.keys
  end
  plays = []
  drive_ids.each do |id|
    plays << drives[id]["plays"]
  end
  binding.pry
end

# file = File.open("nflgame/nflgame/players.json")
# file = JSON.parse(file.read)
# file.each do |player|
#   player = Player.new(
#     first_name: player[1]["first_name"],
#     last_name: player[1]["last_name"],
#     gsis_id: player[1]["gsis_id"],
#     height: player[1]["height"],
#     weight: player[1]["weight"],
#     years_pro: player[1]["years_pro"],
#     position: player[1]["position"])
#   if player.save
#     puts player.first_name + player.last_name + " saved!"
#   end
# end
