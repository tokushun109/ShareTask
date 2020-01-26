FactoryBot.define do
  factory :record do
    progress { "100%" }
    association :task
  end
end
