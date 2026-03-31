Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
    ENV.fetch("GITHUB_CLIENT_ID"),
    ENV.fetch("GITHUB_CLIENT_SECRET")
end

OmniAuth.config.allowed_request_methods = [ :get, :post ]
