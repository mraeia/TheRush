require "csv"

class RushStat < ApplicationRecord

    def self.headers
        [
            {key: 'name',label: 'Player',sortable: false},
            {key: 'team_name',label: 'Team',sortable: false},
            {key: 'position',label: 'Pos',sortable: false},
            {key: 'rushing_attempts_per_game_average',label: 'Att/G',sortable: false},
            {key: 'rushing_attempts',label: 'Att',sortable: false},
            {key: 'total_rushing_yards',label: 'Yds',sortable: true},
            {key: 'rushing_average_yards_per_attempt',label: 'Avg',sortable: false},
            {key: 'rushing_yards_per_game',label: 'Yds/G',sortable: false},
            {key: 'total_rushing_touchdowns',label: 'TD',sortable: true},
            {key: 'longest_rush',label: 'Lng',sortable: true},
            {key: 'rushing_first_downs',label: '1st',sortable: false},
            {key: 'rushing_first_down_percentage',label: '1st%',sortable: false},
            {key: 'rushing_20_plus_yards_each',label: '20+',sortable: false},
            {key: 'rushing_40_plus_yards_each',label: '40+',sortable: false},
            {key: 'rushing_fumbles',label: 'FUM',sortable: false}
        
        ]
    end

    def self.search(params)
        if params[:page].present? && params[:per_page].present?
            if params[:name].present?
                rush_stats = RushStat.where("name ILIKE '%#{params[:name]}%'").paginate(page: params[:page], per_page: params[:per_page])
            else
                rush_stats = RushStat.all.paginate(page: params[:page], per_page: params[:per_page])
            end
        else
            if params[:name].present?
                rush_stats = RushStat.where("name ILIKE '%#{params[:name]}%'")
            else
                rush_stats = RushStat.all
            end
        end

        if params[:sort_by].present?
            if params[:sort_by] == "longest_rush"
                rush_stats = rush_stats.order(longest_rush: params[:sort_order],longest_rush_touchdown: params[:sort_order])
            else
                rush_stats = rush_stats.order("#{params[:sort_by]} #{params[:sort_order]}")
            end
        end

        rush_stats
    end

    def self.to_csv(params)
        rush_stats = self.search(params)

        attributes = self.headers.map{|col| col[:label]}
        CSV.generate(headers: true) do |csv|
            csv << attributes

            rush_stats.each_with_index do |stat,index|
                record = []

                record << stat.name
                record << stat.team_name
                record << stat.position
                record << stat.rushing_attempts_per_game_average
                record << stat.rushing_attempts
                record << stat.total_rushing_yards
                record << stat.rushing_average_yards_per_attempt
                record << stat.rushing_yards_per_game
                record << stat.total_rushing_touchdowns
                record << "#{stat.longest_rush}#{stat.longest_rush_touchdown ? 'T' : ''}"
                record << stat.rushing_first_downs
                record << stat.rushing_first_down_percentage
                record << stat.rushing_20_plus_yards_each
                record << stat.rushing_40_plus_yards_each
                record << stat.rushing_fumbles

                csv << record
            end
        end
    end
end
