FactoryBot.define do
  factory :group do
    name { 'Example Group' }
    association :leader_user, factory: :user
  end

  factory :other_group do
    name { Faker::Team.creature }
    association :leader_user, factory: :user
  end
end
