class Api::GithubsController < ApplicationController
  def contributions
    user = current_user
    # 将来的に1年前とcreated_atを比較して新しい方をfromにするかも
    from = user.created_at.utc.iso8601
    to = Time.current.utc.iso8601

    service = GithubService.new(user.name)
    data = service.fetch_contributions(from: from, to: to)

    user.last_grass_check_date = Time.current
    user.save!

    render json: data
  end
end
