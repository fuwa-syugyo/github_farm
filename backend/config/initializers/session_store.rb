Rails.application.config.session_store :cookie_store,
  key: '_github_farm_session',
  same_site: :none,
  secure: false,
  domain: :all
