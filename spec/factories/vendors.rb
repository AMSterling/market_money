FactoryBot.define do
  factory :vendor do
    name { Faker::Commerce.vendor }
    description { Faker::Address.street_address }
    contact_name { Faker::Address.city }
    contact_phone { "#{city} County" }
    state { Faker::Address.state }
    credit_accepted { %w[true false].sample }
  end
end
