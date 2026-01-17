class NotificationSetting < ApplicationRecord
  belongs_to :user

  enum :notification_type, {
    grass_remind: 0,
    animal_recovered: 1,
    animal_escape_warning: 2
  }

  validates :notify_hour,
    inclusion: { in: 0..23 }
end
