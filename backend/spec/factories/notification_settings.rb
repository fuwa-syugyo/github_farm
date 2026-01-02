FactoryBot.define do
  factory :notification_setting do
    user { nil }
    notification_type { 1 }
    enabled { true }
    notify_hour { 21 }
  end
end
