class Team < ApplicationRecord
  has_one_attached :logo

  has_many :players, dependent: :nullify
  has_many :team_1_games, class_name: "Game", foreign_key: "team_1_id", dependent: :destroy
  has_many :team_2_games, class_name: "Game", foreign_key: "team_2_id", dependent: :destroy

  validates :name, uniqueness: true
  validate :correct_logo_type

  def total_wins
    count = 0
    self.team_1_games.each do |game|
      count += 1 if (game.home_game_goal_team_1 + game.away_game_goal_team_1) > (game.home_game_goal_team_2 + game.away_game_goal_team_2)
    end

    team_2_games.each do |game|
      count += 1 if (game.home_game_goal_team_1 + game.away_game_goal_team_1) < (game.home_game_goal_team_2 + game.away_game_goal_team_2)
    end
    count
  end

  def total_draws
    count = 0
    team_1_games.each do |game|
      count += 1 if (game.home_game_goal_team_1 + game.away_game_goal_team_1).eql? (game.home_game_goal_team_2 + game.away_game_goal_team_2)
    end

    team_2_games.each do |game|
      count += 1 if (game.home_game_goal_team_1 + game.away_game_goal_team_1).eql? (game.home_game_goal_team_2 + game.away_game_goal_team_2)
    end
    count
  end

  def total_loses
    count = 0
    team_1_games.each do |game|
      count += 1 if (game.home_game_goal_team_1 + game.away_game_goal_team_1) < (game.home_game_goal_team_2 + game.away_game_goal_team_2)
    end

    team_2_games.each do |game|
      count += 1 if (game.home_game_goal_team_1 + game.away_game_goal_team_1) > (game.home_game_goal_team_2 + game.away_game_goal_team_2)
    end
    count
  end

  def get_player_by_type(type)
    self.players.find_by(playing_position: type.capitalize)
  end

  private

  def correct_logo_type
    if logo.attached? and !logo.content_type.in?(%w[image/jpg image/jpeg image/png])
      errors.add(:logo, "file type is invalid.")
    end
  end

end
