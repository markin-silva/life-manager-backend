# Default system categories
Category.find_or_create_by!(key: "food", system: true) do |category|
  category.color = "#FF6B6B"
  category.icon = "utensils"
end

Category.find_or_create_by!(key: "transport", system: true) do |category|
  category.color = "#4D96FF"
  category.icon = "bus"
end

Category.find_or_create_by!(key: "housing", system: true) do |category|
  category.color = "#6BCB77"
  category.icon = "home"
end
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
