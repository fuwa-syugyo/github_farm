require "rails_helper"

RSpec.describe GrassReminderService do
  describe "#call" do
    let(:now) { Time.zone.parse("2026-02-22 22:00:00") }

    let!(:target_user) do
      create(:user, last_contribution_date: Date.yesterday)
    end

    let!(:target_setting) do
      create(:notification_setting,
        user: target_user,
        notify_hour: 22)
    end

    let!(:other_hour_user) do
      create(:user, last_contribution_date: Date.yesterday)
    end

    let!(:other_hour_setting) do
      create(:notification_setting,
        user: other_hour_user,
        notify_hour: 21)
    end

    let!(:grass_done_user) do
      create(:user, last_contribution_date: Date.today)
    end

    let!(:grass_done_setting) do
      create(:notification_setting,
        user: grass_done_user,
        notify_hour: 22)
    end

    before do
      allow(PushNotifier).to receive(:send_grass_reminder)
    end

    it "notify_hourが一致し草が生えていないユーザーに通知する" do
      described_class.call(now: now)

      expect(PushNotifier)
        .to have_received(:send_grass_reminder)
        .with(target_user)

      expect(PushNotifier)
        .not_to have_received(:send_grass_reminder)
        .with(other_hour_user)

      expect(PushNotifier)
        .not_to have_received(:send_grass_reminder)
        .with(grass_done_user)
    end
  end
end
