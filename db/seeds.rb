# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
Review.destroy_all
User.destroy_all

50.times do |index|
  product = Product.create!({name: Faker::Food.ingredient, cost: Faker::Number.between(from: 1, to: 100), country_of_origin: Faker::Address.country})
  5.times do |index|
    Review.create!({author: Faker::Books::Dune.character, content_body: Faker::Lorem.paragraph_by_chars(number: 150, supplemental: false), rating: Faker::Number.between(from: 1, to: 5), product_id: product.id})
  end
end

1.times do |index|
  user = User.create({email: 'admin@email.com', password: 'testing', admin: true})
end

1.times do |index|
  user = User.create({email: 'user@email.com', password: 'testing'})
end

p "Created #{User.count} users"
p "Created #{Product.count} products"
p "Created #{Review.count} reviews"