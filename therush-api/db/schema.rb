# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_29_110147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rush_stats", force: :cascade do |t|
    t.string "name"
    t.string "team_name"
    t.string "position"
    t.float "rushing_attempts_per_game_average"
    t.integer "rushing_attempts"
    t.integer "total_rushing_yards"
    t.float "rushing_average_yards_per_attempt"
    t.float "rushing_yards_per_game"
    t.integer "total_rushing_touchdowns"
    t.integer "longest_rush"
    t.boolean "longest_rush_touchdown"
    t.integer "rushing_first_downs"
    t.float "rushing_first_down_percentage"
    t.integer "rushing_20_plus_yards_each"
    t.integer "rushing_40_plus_yards_each"
    t.integer "rushing_fumbles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["longest_rush", "longest_rush_touchdown"], name: "index_rush_stats_on_longest_rush_and_longest_rush_touchdown"
    t.index ["name"], name: "index_rush_stats_on_name"
    t.index ["total_rushing_touchdowns"], name: "index_rush_stats_on_total_rushing_touchdowns"
    t.index ["total_rushing_yards"], name: "index_rush_stats_on_total_rushing_yards"
  end

end
