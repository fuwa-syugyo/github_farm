class Api::GithubsController < ApplicationController
  def contributions
    user = current_user
    from = (user.last_grass_check_date || user.created_at).utc.iso8601
    to = Time.current.utc.iso8601

    service = GithubService.new(user.name)
    data = service.fetch_contributions(from: from, to: to)

    render json: data
  end
end
