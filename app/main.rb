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
  games.insert(
    datetime: game_ins.datetime,
    game_week: game_ins.game_week,
    home_team: game_ins.home_team,
    away_team: game_ins.away_team,
    tweet_flag: false
  )
end

# 試合開始時間ごとにハイライトURLを取得するcronを設定する
this_week_games = games.where(game_week: game_array[0][0])
uniq_datetimes = this_week_games.map { |game| game[:datetime] }.uniq

uniq_datetimes.each do |datetime|
  # この試合時間のhomeを取得する
  this_time_games = this_week_games.where(datetime: datetime)
  hometeams = this_time_games.map(:home_team)
  puts "#{datetime}の試合のホームチームは #{hometeams.join(',')} です"
  # wheneverでcronを設定する(引数にhomeチームを渡す)
# crontab を設定し終えたら、ファイルの更新を実行する
system('whenever --update-crontab')

