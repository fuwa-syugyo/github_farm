class Api::NotificationSettingsController < ApplicationController
  DEFAULT_TYPE = "grass_remind"

  def show
    setting = find_setting
    if setting
      render json: setting
    else
      render json: {
        notify_hour: "",
        enabled: true
      }
    end
  end

  def create
    setting = find_setting || current_user.notification_settings.build(notification_type: DEFAULT_TYPE)
    setting.assign_attributes(notification_setting_params)

    if setting.save
      render json: setting, status: :ok
    else
      render json: { errors: setting.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    create
  end

  private

  def find_setting
    current_user.notification_settings.find_by(notification_type: DEFAULT_TYPE)
  end

  def notification_setting_params
    params.require(:notification_setting).permit(:notify_hour, :enabled)
  end
end
