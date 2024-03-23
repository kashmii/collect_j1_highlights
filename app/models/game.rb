require 'sequel'

class Game < Sequel::Model
  attr_accessor :game_week, :datetime, :home_team, :away_team, :highlight_url, :tweet_flag

  def initialize(game_week, datetime, home_team, away_team, highlight_url = "", tweet_flag = false)
    @game_week = game_week
    @datetime = datetime
    @home_team = home_team
    @away_team = away_team
  end
end