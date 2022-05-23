require 'humanize'

def seed_teams
  puts "Seeding teams..."

  unless Team.any?
    (1..20).each do |i|
      team = Team.new
      team.name = "Team " + i.humanize.capitalize
      team.description = "This is " + team.name.upcase + "!"
      team.save!
    end
  end

  puts "Seeding teams completed..."
end

seed_teams
