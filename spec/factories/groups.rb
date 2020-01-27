FactoryBot.define do
  factory :group do
    name { 'Example Group' }
    association :leader_user, factory: :user
  end
end
