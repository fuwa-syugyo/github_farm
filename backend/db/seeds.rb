# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Animal.create!([
  { name: "ハチドリ", recovery_days: 14, escape_days: 1 },
  { name: "パンダ", recovery_days: 30, escape_days: 3 },
  { name: "アルパカ", recovery_days: 50, escape_days: 5 }
])
