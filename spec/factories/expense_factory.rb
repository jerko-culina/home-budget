FactoryBot.define do
  factory :expense do
    title { Faker::Name.name }
    category { create(:category) }
    amount  { 100 }
  end
end