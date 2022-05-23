class HomeController < ApplicationController
  def index
    @season_team_names = {}
    @season_team_points = {}
    @season_team_goals_scored = {}
    @season_team_goals_conceded = {}
    Season.all.each do |season|
      team_names = []
      team_points = []
      team_goal_scored = []
      team_goal_conceded = []
      Team.all.each do |team|
        team_names << team.name
        
        points = 0
        goal_scored = 0
        goal_conceded = 0
        team.team_1_games.where(season: season).each do |game|
          goal_scored += game.home_game_goal_team_1 + game.away_game_goal_team_1
          goal_conceded += game.home_game_goal_team_2 + game.away_game_goal_team_2
          
          points += 3 if (game.home_game_goal_team_1 + game.away_game_goal_team_1) > (game.home_game_goal_team_2 + game.away_game_goal_team_2)
          points += 1 if (game.home_game_goal_team_1 + game.away_game_goal_team_1).eql? (game.home_game_goal_team_2 + game.away_game_goal_team_2)          
        end

        team.team_2_games.where(season: season).each do |game|
          goal_scored += game.home_game_goal_team_2 + game.away_game_goal_team_2
          goal_conceded += game.home_game_goal_team_1 + game.away_game_goal_team_1
          
          points += 3 if (game.home_game_goal_team_1 + game.away_game_goal_team_1) < (game.home_game_goal_team_2 + game.away_game_goal_team_2)
          points += 1 if (game.home_game_goal_team_1 + game.away_game_goal_team_1).eql? (game.home_game_goal_team_2 + game.away_game_goal_team_2)
        end
        
        team_points << points
        team_goal_scored << goal_scored
        team_goal_conceded << goal_conceded
      end
      @season_team_names[season.title] = team_names
      @season_team_points[season.title] = team_points
      @season_team_goals_scored[season.title] = team_goal_scored
      @season_team_goals_conceded[season.title] = team_goal_conceded
    end
  end
end
