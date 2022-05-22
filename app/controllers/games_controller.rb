class GamesController < ApplicationController
  
  before_action :set_season, only: %i[ new create edit update index destroy ]
  before_action :set_game, only: %i[ edit update destroy ]
  
  def index
    @games = @season.games
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.season = @season
    @game.inspect

    respond_to do |format|
      if @game.save
        format.html { redirect_to season_games_url(@season, @game), notice: "Player was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to season_url(@season), notice: "Season was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to season_games_path(@season), notice: "Game was successfully destroyed." }
    end
  end

  private
  
  def set_season
    @season = Season.find(params[:season_id])
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(
      :team_1_id,
      :team_2_id,
      :home_game_goal_team_1,
      :away_game_goal_team_2,
      :away_game_goal_team_1,
      :home_game_goal_team_2
    )
  end
end
