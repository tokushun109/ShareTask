FactoryBot.define do
  factory :task do
    name { "Example task" }
    in_charge { "Example user" }
    status { "imcomplete" }
    association :post_user, factory: :user
    association :post_group, factory: :group
  end
end
