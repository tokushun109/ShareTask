FactoryBot.define do
  factory :user do
    name { "Example User" }
    user_name { "Example User Name" }
    email { "user@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
