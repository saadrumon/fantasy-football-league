class AddIsTeamManagedToSeasons < ActiveRecord::Migration[6.1]
  def change
    add_column :seasons, :is_team_managed, :boolean, default: false
  end
end
