require 'sequel'

# Game クラスを読んでくる前にDBを読み込む
DB = Sequel.connect('sqlite://game.db')

require './app/scraping/read_local_data'
require './app/models/game'

games = DB[:games]

# できた配列をループさせ今節のgameを保存する
game_array = read_local_data

puts game_array

game_array.each do |game|
  game_ins = Game.new(game[0], game[1], game[2], game[3])
  games.insert(date: game_ins.date, game_week: game_ins.game_week, home_team: game_ins.home_team, away_team: game_ins.away_team, tweet_flag: false)
end