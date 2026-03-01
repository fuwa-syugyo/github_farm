class GrassReminderJob < ApplicationJob
  queue_as :default

  def perform
    GrassReminderService.call
  end
end
