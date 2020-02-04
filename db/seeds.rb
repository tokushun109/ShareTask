# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Example User",
             user_name: "Example User Name",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

# 99.times do |n|
#   name  = Faker::Name.name
#   user_name = "example-#{n+1} User Name"
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   User.create!(name:  name,
#                user_name: user_name,
#                email: email,
#                password:              password,
#                password_confirmation: password)
# end

# マイクロポスト
# usersの中から生成した順に6人の配列を作成する
user = User.first
# 50.times do
  content = Faker::Job
  user.leader_groups.create!(name: content)
# end
