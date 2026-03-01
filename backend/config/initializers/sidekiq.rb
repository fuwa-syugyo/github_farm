require "sidekiq-cron"

Sidekiq.configure_server do |config|
  schedule_file = "config/sidekiq.yml"

  if File.exist?(schedule_file)
    yaml = YAML.load_file(schedule_file)
    schedule = yaml.deep_symbolize_keys[:schedule]
    Sidekiq::Cron::Job.load_from_hash(schedule) if schedule.present?
  end
end
