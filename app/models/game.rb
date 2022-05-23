class Game < ApplicationRecord
  belongs_to :season
  belongs_to :team_1, class_name: 'Team', foreign_key: 'team_1_id'
  belongs_to :team_2, class_name: 'Team', foreign_key: 'team_2_id'
  
  validate :restrict_same_team

  private

  def restrict_same_team
    if team_1.name.eql? team_2.name
      errors.add(:team_1, "can't be same as Team 2.")
    end
  end
end
