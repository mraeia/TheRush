class RushStatsController < ApplicationController
  before_action :set_rush_stat, only: %i[ show update destroy ]

  # GET /rush_stats
  # GET /rush_stats.json
  def index
    @rush_stats = RushStat.all
  end

  # GET /rush_stats/1
  # GET /rush_stats/1.json
  def show
  end

  # POST /rush_stats
  # POST /rush_stats.json
  def create
    @rush_stat = RushStat.new(rush_stat_params)

    if @rush_stat.save
      render :show, status: :created, location: @rush_stat
    else
      render json: @rush_stat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rush_stats/1
  # PATCH/PUT /rush_stats/1.json
  def update
    if @rush_stat.update(rush_stat_params)
      render :show, status: :ok, location: @rush_stat
    else
      render json: @rush_stat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rush_stats/1
  # DELETE /rush_stats/1.json
  def destroy
    @rush_stat.destroy
  end

  def search
    @rush_stats = RushStat.search(params)
  end

  def download_csv
    send_data RushStat.to_csv(params), type: "text/csv"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rush_stat
      @rush_stat = RushStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rush_stat_params
      params.require(:rush_stat).permit(:name, :team_name, :position, :rushing_attempts_per_game_average, :rushing_attempts, :total_rushing_yards, :rushing_average_yards_per_attempt, :rushing_yards_per_game, :total_rushing_touchdowns, :longest_rush, :longest_rush_touchdown, :rushing_first_downs, :rushing_first_downs, :rushing_first_down_percentage, :rushing_20_plus_yards_each, :rushing_40_plus_yards_each, :rushing_fumbles)
    end
end
