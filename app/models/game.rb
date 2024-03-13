require 'sequel'

class Game < Sequel::Model
  attr_accessor :date, :game_week, :home_team, :away_team, :highlight_url, :tweet_flag

  def initialize(date, game_week, home_team, away_team, highlight_url = "", tweet_flag = false)
    @date = date
    @game_week = game_week
    @home_team = home_team
    @away_team = away_team
  end
end