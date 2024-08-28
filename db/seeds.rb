# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: 'admin@test.com', password: 'password')

if false
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
end

user_attributes = [
    { name: "山田", email: "user1@test.com", password: "password" },
    { name: "すずきん", email: "user2@test.com", password: "password" },
    { name: "(_ _)", email: "user3@test.com", password: "password" },
    { name: "azuma", email: "user4@test.com", password: "password" },
    { name: "宮本様", email: "user5@test.com", password: "password" },
  ]

users = user_attributes.map do |attr|
  User.create!(attr)
end

post_attributes = [
    {
      user_id: 1,
      title: "しましまロール",
      content: "チョコとバニラのハーモニー",
      shop_name: "しま",
      price: 1500,
      sweetness: 4,
      looks: 3,
      cost_performance: 5
    },
    {
      user_id: 1,
      title: "ザクザクチョコクレープ",
      content: "ザクザクしすぎて口切りそう",
      shop_name: "クレープ王",
      price: 800,
      sweetness: 5,
      looks: 4,
      cost_performance: 4
    },
    {
      user_id: 2,
      title: "ハワイ的パンケーキ",
      content: "クリームの量がエグい。\nかなりボリュームがあるので、注意。",
      shop_name: "ロコモコ",
      price: 2000,
      sweetness: 5,
      looks: 4,
      cost_performance: 3
    },
    {
      user_id: 3,
      title: "丸ごと桃のケーキ",
      content: "桃です。",
      shop_name: "リンデンバウム",
      price: 900,
      sweetness: 4,
      looks: 5,
      cost_performance: 4
    },
    {
      user_id: 4,
      title: "10段ソフト",
      content: "もらった瞬間落ちました。",
      shop_name: "ソフト専門店なかもと",
      price: 900,
      sweetness: 1,
      looks: 1,
      cost_performance: 1
    },
  ]

posts = post_attributes.map do |attr|
  Post.create!(attr)
end

post_size = posts.count
user_size = users.count

comments = %w(
    美味しかった。また食べたい。
    かなり映えるので、是非食べる前に撮っておきましょう。\nなかなかボリュームもありました。
    甘い！甘すぎる！
    そこにしびれるあこがれるっ！！
    めっちゃ美味しかった。
    ２〜３人で食べたほうが良いかも。
  )

(1..10).each do |i|
  Comment.create!(user_id: rand(1..user_size),
                  post_id: rand(1..post_size),
                  content: comments.sample,
                  star: rand(1..5))
end

patterns = [[1, 2], [1, 3], [2, 4], [3, 1], [3, 2], [3, 4]]

patterns.each do |a|
  Favorite.create!(user_id: a.last, post_id: a.first)
  Relationship.create!(follower_id: a.first, followed_id: a.last)
end
