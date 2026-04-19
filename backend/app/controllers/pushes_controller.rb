class PushesController < ApplicationController
  def create
    PushSubscription.find_each do |sub|
      WebPush.payload_send(
        message: { title: "テスト", body: "テストです" }.to_json,
        endpoint: sub.endpoint,
        p256dh: sub.p256dh,
        auth: sub.auth,
        vapid: {
          subject: "mailto:test@example.com",
          public_key: ENV["VAPID_PUBLIC_KEY"],
          private_key: ENV["VAPID_PRIVATE_KEY"]
        }
      )
    end

    render json: { ok: true }
  end
end