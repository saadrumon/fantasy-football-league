require 'humanize'

def seed_players
  puts "Seeding players..."

  playing_position = ["Goalkeeper", "Defender", "Midfielder", "Striker"]
  
  unless Player.any?
    (1..80).each do |i|
      player = Player.new
      player.first_name = 'Player'
      player.last_name = i.humanize.capitalize
      player.date_of_birth = Time.now - 25.years
      player.playing_position = playing_position[i % 4]
      player.save!
    end
  end

  puts "Seeding players completed..."
end

seed_players
