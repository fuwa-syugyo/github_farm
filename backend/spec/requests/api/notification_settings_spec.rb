# spec/requests/api/notification_settings_spec.rb
require "rails_helper"

RSpec.describe "Api::NotificationSettings", type: :request do
  let(:user) { create(:user) }

  describe "GET /api/notification_setting" do
    context "通知設定が未作成場合" do
      before do
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user)
          .and_return(user)
      end

      it "デフォルト値を返す" do
        get "/api/notification_setting",
          headers: {
            "Host" => "localhost",
            "Origin" => "http://localhost:3000"
          }

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json["notify_hour"]).to eq ""
        expect(json["enabled"]).to eq true
      end
    end
  end

  describe "PUT /api/notification_setting" do
    context "ログインしている場合" do
      before do
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user)
          .and_return(user)
      end

      it "通知設定を保存できる" do
        put "/api/notification_setting",
          params: {
            notification_setting: {
              notify_hour: 22,
              enabled: true
            }
          },
          headers: {
            "Host" => "localhost",
            "Origin" => "http://localhost:3000"
          }

        expect(response).to have_http_status(:ok)

        setting = user.notification_settings.first
        expect(setting.notify_hour).to eq 22
        expect(setting.enabled).to eq true
      end
    end

    context "ログインしていない場合" do
      it "401を返す" do
        put "/api/notification_settings",
          params: {
            notification_setting: {
              notify_hour: 22,
              enabled: true
            }
          }

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
