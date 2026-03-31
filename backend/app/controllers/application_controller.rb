class ApplicationController < ActionController::API
  def current_user
    puts "テスト"
    Rails.logger.info request.origin
    puts request.headers["Origin"]
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end
end
