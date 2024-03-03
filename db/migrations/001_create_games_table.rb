require 'sequel'
require 'sqlite3'

DB = Sequel.connect('sqlite://game.db')

Sequel.migration do
  change do
    create_table(:games) do
      primary_key :id
      Date :date
      Integer :game_week
      String :home_team
      String :away_team
      String :highlight_url
      TrueClass :tweet_flag
    end
  end
end
