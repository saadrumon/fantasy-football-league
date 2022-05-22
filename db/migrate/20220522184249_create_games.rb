class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.references :team_1, foreign_key: { to_table: 'teams' }
      t.references :team_2, foreign_key: { to_table: 'teams' }
      t.references :season
      
      t.integer :home_game_goal_team_1
      t.integer :home_game_goal_team_2
      t.integer :away_game_goal_team_1
      t.integer :away_game_goal_team_2

      t.timestamps
    end
  end
end
