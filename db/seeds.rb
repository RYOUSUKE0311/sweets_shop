# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: 'admin@test.com', password: 'password')

(1..10).each do |n|
  user = User.create!(name: "user#{n}", email: "user#{n}@test.com", password: "password")
  (0..rand(0..5)).each do |i|
    user.posts.create!(
      title: "sample#{n}-#{i}",
      content: "#{"xxx"*rand(5..10)}\n"*rand(3..5),
      shop_name: "shop#{n}-#{i}",
      price: rand(3..10) * 100,
      sweetness: rand(2..5),
      looks: rand(2..5),
      cost_performance: rand(2..5)
    )
  end
end