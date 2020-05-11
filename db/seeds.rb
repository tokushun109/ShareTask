# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: 'test',
             user_name: 'test_user',
             email: 'test@test.com',
             password: 'testlogin',
             password_confirmation: 'testlogin')

20.times do |n|
  name = Faker::Name.name
  user_name = "example-#{n + 1} User Name"
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               user_name: user_name,
               email: email,
               password: password,
               password_confirmation: password)
end

User.create!(name: '鈴木',
             user_name: 'suzuki',
             email: 'suzuki@user.com',
             password: 'suzuki',
             password_confirmation: 'suzuki')

User.create!(name: '田中',
             user_name: 'tanaka',
             email: 'tanaka@user.com',
             password: 'tanaka',
             password_confirmation: 'tanaka')

User.create!(name: '山田',
             user_name: 'yamada',
             email: 'yamada@user.com',
             password: 'yamada',
             password_confirmation: 'yamada')


user = User.first
11.times do
  content = Faker::Team.creature
  group = user.leader_groups.create!(name: content)
  user.relationships.create!(group_id: group.id, status: 'accept')
end

group = Group.first
time_limit = Time.zone.now
11.times do
  name = Faker::Job.seniority
  user.tasks.create!(name: name,
                    in_charge: 'Example User',
                    time_limit: time_limit,
                    status: 'incomplete',
                    post_group_id: group.id)
end

suzuki = User.find_by(name: '鈴木')
group_name = '設計開発チーム'
suzuki_group = suzuki.leader_groups.create!(name: group_name)
suzuki.relationships.create!(group_id: suzuki_group.id, status: 'accept')

suzuki.tasks.create!(name: '試作品作成',
                    in_charge: '田中',
                    time_limit: Time.zone.now.since(4.days),
                    status: 'incomplete',
                    post_group_id: suzuki_group.id)

suzuki.tasks.create!(name: 'DR資料作成',
                    in_charge: '鈴木',
                    time_limit: Time.zone.now.since(5.days),
                    status: 'incomplete',
                    post_group_id: suzuki_group.id)

suzuki.tasks.create!(name: '評価検討',
                    in_charge: '山田',
                    time_limit: Time.zone.now.since(6.days),
                    status: 'incomplete',
                    post_group_id: suzuki_group.id)

task1 = Task.first
n = 5
19.times do
  task1.records.create!(progress: n,
                       supplement: 'Example',
                       created_at: n.days.since)
  n += 5
end

task2 = Task.second
task2.records.create!(progress: 50,
                     supplement: 'Example',
                     created_at: 5.days.since)

tanaka_task = Task.find_by(name: '試作品作成')
tanaka_task.records.create!(progress: 70,
                    supplement: '設計図作成終了',
                    created_at: Time.zone.now.since(2.days))

tanaka_task.records.create!(progress: 90,
                    supplement: '試作品作成を依頼',
                    created_at: Time.zone.now.since(4.days))

suzuki_task = Task.find_by(name: 'DR資料作成')
suzuki_task.records.create!(progress: 50,
                    supplement: '報告資料作成中',
                    created_at: Time.zone.now.since(3.days))

yamada_task = Task.find_by(name: '評価検討')
yamada_task.records.create!(progress: 20,
                    supplement: '検討準備中',
                    created_at: Time.zone.now.since(3.days))
