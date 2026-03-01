class GrassReminderService
  def self.call(now: Time.zone.now)
    hour = now.hour

    NotificationSetting
      .where(notify_hour: hour)
      .where(enabled: true)
      .find_each do |setting|
      user = setting.user

      next if user.grass_today?
      # next if setting.notified_today? TODO: 後でNotificationSettingsに今日通知済みかどうかのカラムを追加する

      PushNotifier.send_grass_reminder(user)
      # setting.mark_notified_today! # TODO: 今日の日付をカラムに入れて、通知済みであることをマーク
    end
  end
end
