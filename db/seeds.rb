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

20.times do |n|
  name  = Faker::Name.name
  user_name = "example-#{n+1} User Name"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               user_name: user_name,
               email: email,
               password:              password,
               password_confirmation: password)
end

user = User.first
11.times do
  content = Faker::Team.creature
  group = user.leader_groups.create!(name: content)
  user.relationships.create!(group_id: group.id, status: "accept")
end

group = Group.first
time_limit = Time.zone.now.since(3.days)
11.times do
  name = Faker::Job.seniority
  user.tasks.create(name: name,
                    in_charge: "Example User",
                    time_limit: time_limit,
                    status: 'imcomplete',
                    post_group_id: group.id)
end

task = Task.first
n = 5
20.times do
  task.records.create(progress: "#{n}%",
                    supplement: "Example")
  n += 5
end
