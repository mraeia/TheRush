class CreateRushStats < ActiveRecord::Migration[5.2]
  def change
    create_table :rush_stats do |t|
      t.string :name
      t.string :team_name
      t.string :position
      t.float :rushing_attempts_per_game_average
      t.integer :rushing_attempts
      t.integer :total_rushing_yards
      t.float :rushing_average_yards_per_attempt
      t.float :rushing_yards_per_game
      t.integer :total_rushing_touchdowns
      t.integer :longest_rush
      t.boolean :longest_rush_touchdown
      t.integer :rushing_first_downs
      t.integer :rushing_first_downs
      t.float :rushing_first_down_percentage
      t.integer :rushing_20_plus_yards_each
      t.integer :rushing_40_plus_yards_each
      t.integer :rushing_fumbles

      t.timestamps
    end

    file = File.open "./rushing.json"
    data = JSON.load file

    rushing_stats = data.map do |stat|
      {
      name: stat["Player"],
      team_name: stat["Team"],
      position: stat["Pos"],
      rushing_attempts_per_game_average: stat["Att/G"],
      rushing_attempts: stat["Att"],
      total_rushing_yards: stat["Yds"].to_s.tr(',',''),
      rushing_average_yards_per_attempt: stat["Avg"],
      rushing_yards_per_game: stat["Yds/G"],
      total_rushing_touchdowns: stat["TD"],
      longest_rush: stat["Lng"].to_s.match(/(-?\d+)(T?)/)[1],
      longest_rush_touchdown: stat["Lng"].to_s.match(/(-?\d+)(T?)/)[2].empty? ? false : true,
      rushing_first_downs: stat["1st"],
      rushing_first_down_percentage: stat["1st%"],
      rushing_20_plus_yards_each: stat["20+"],
      rushing_40_plus_yards_each: stat["40+"],
      rushing_fumbles: stat["FUM"]
      }
    end

    RushStat.create(rushing_stats)
  end
end
