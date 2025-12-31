FactoryBot.define do
  factory :user do
    name  { "testuser" }
    id { 12345 }
    uid { "123456" }

    last_grass_check_date { nil }
    last_contribution_date { nil }

    created_at { 1.month.ago }
  end
end
