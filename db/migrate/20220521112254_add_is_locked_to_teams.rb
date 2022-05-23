class AddIsLockedToTeams < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :is_locked, :boolean, default: false
  end
end
