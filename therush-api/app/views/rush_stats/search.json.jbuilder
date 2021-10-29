json.columns RushStat.headers
json.records do
    json.array! @rush_stats.each do |r_s|
        json.array! [r_s.name, r_s.team_name, r_s.position, r_s.rushing_attempts_per_game_average, r_s.rushing_attempts, r_s.total_rushing_yards, r_s.rushing_average_yards_per_attempt, r_s.rushing_yards_per_game, r_s.total_rushing_touchdowns, "#{r_s.longest_rush}#{r_s.longest_rush_touchdown ? 'T' : ''}", r_s.rushing_first_downs, r_s.rushing_first_down_percentage, r_s.rushing_20_plus_yards_each, r_s.rushing_40_plus_yards_each, r_s.rushing_fumbles]
    end
end

json.total_pages @rush_stats.total_pages