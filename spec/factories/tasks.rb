FactoryBot.define do
  factory :task do
    name { 'Example task' }
    in_charge { 'Example user' }
    status { 'imcomplete' }
    time_limit { Time.zone.now }
    association :post_user, factory: :user
    association :post_group, factory: :group
  end
end
