# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

animals = [
  { name: "ひよこ", recovery_days: 14, escape_days: 1, image_url: "/images/hiyoko.png" },
  { name: "パンダ", recovery_days: 30, escape_days: 3, image_url: "/images/panda.png" },
  { name: "アルパカ", recovery_days: 50, escape_days: 5, image_url: "/images/alpaca.png" }
]

animals.each do |animal_data|
  Animal.find_or_create_by!(name: animal_data[:name]) do |animal|
    animal.recovery_days = animal_data[:recovery_days]
    animal.escape_days = animal_data[:escape_days]
    animal.image_url = animal_data[:image_url]
  end
end
