FactoryBot.define do
  factory :user do
    name  { "testuser" }
    uid { SecureRandom.uuid }

    last_grass_check_date { nil }
    last_contribution_date { nil }

    created_at { 1.month.ago }
  end
end
