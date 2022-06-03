FactoryBot.define do
  factory :category do
    name { Faker::Name.name }
    user  { create(:user) }
  end
end