Rails.application.config.middleware.use OmniAuth::Builder do
  unless Rails.env.test?
    provider :github,
      ENV.fetch("GITHUB_CLIENT_ID"),
      ENV.fetch("GITHUB_CLIENT_SECRET")
  end
end

OmniAuth.config.allowed_request_methods = [ :get, :post ]
