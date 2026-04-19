class PushSubscriptionsController < ApplicationController
  def create
    sub = params[:subscription]

    PushSubscription.create!(
      endpoint: sub[:endpoint],
      p256dh: sub[:keys][:p256dh],
      auth: sub[:keys][:auth]
    )

    render json: { ok: true }
  end
end
