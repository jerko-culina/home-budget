FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password  { "thisisvalidpassword" }
    auth_token { SecureRandom.alphanumeric(20) }
    available { 1000 }
  end
end