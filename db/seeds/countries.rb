require 'csv'

def seed_countries
  puts "Seeding countries..."

  file_path = File.join(File.dirname(__FILE__), 'data', 'countries.csv')
  file = File.read(file_path)
  data = CSV.parse(file, headers: true)

  data.each do |row|
    country = row["Country"]
    if Country.find_by(name: country).nil?
      Country.create!(name: country)
    end
  end

  puts "Seeding countries completed..."
end

seed_countries
