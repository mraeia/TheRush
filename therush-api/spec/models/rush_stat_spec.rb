require 'rails_helper'

RSpec.describe RushStat, type: :model do
  describe "Test search() method on RushStat model" do
    it "filters by name" do
      rush_stats = RushStat.search({name: "mi"})
      expect(rush_stats.pluck(:name)).to all(match(%r{#{"mi"}}i))
    end

    it "orders by Total Rushing Yards ascending" do
      rush_stats = RushStat.search({name: "mi", sort_by: "total_rushing_yards", sort_order: "asc"})
      rush_stats.pluck(:total_rushing_yards).each_cons(2) do |consecutive_yards|
        expect(consecutive_yards[0]).to be <= consecutive_yards[1]
      end
    end

    it "orders by Total Rushing Touchdowns descending" do
      rush_stats = RushStat.search({name: "mi", sort_by: "total_rushing_touchdowns", sort_order: "desc"})
      rush_stats.pluck(:total_rushing_touchdowns).each_cons(2) do |consecutive_touchdowns|
        expect(consecutive_touchdowns[0]).to be >= consecutive_touchdowns[1]
      end
    end

    it "orders by Longest Rush ascending" do
      rush_stats = RushStat.search({name: "mi", sort_by: "longest_rush", sort_order: "asc"})
      rush_stats.pluck(:longest_rush,:longest_rush_touchdown).each_cons(2) do |consecutive_rushes|
        if consecutive_rushes[0][0] == consecutive_rushes[1][0]
          expect(consecutive_rushes[0][1] ? 1 : 0).to be <= (consecutive_rushes[1][1] ? 1 : 0)
        else
          expect(consecutive_rushes[0][0]).to be <= (consecutive_rushes[1][0])
        end
      end
    end
  end
end
