Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :github,
      ENV["GITHUB_CLIENT_ID"],
      ENV["GITHUB_CLIENT_SECRET"]
  else
    provider :github,
      # 本番用のIDとSECRETを用意したら書き換える
      Rails.application.credentials.github[:client_id],
      Rails.application.credentials.github[:client_secret]
  end
end

OmniAuth.config.allowed_request_methods = [ :get, :post ]
