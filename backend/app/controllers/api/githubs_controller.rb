class Api::GithubsController < ApplicationController
  def contributions
    data = fetch_contributions
    update_user_last_contribution_date(data)

    render json: data
  end

  private

  def fetch_contributions
    user = current_user
    # 将来的に1年前とcreated_atを比較して新しい方をfromにするかも
    from = user.created_at.utc.iso8601
    to = Time.current.utc.iso8601

    GithubService
      .new(user.name)
      .fetch_contributions(from: from, to: to)
  end

  def update_user_last_contribution_date(data)
    last_contribution = last_contribution_day(data)

    current_user.update!(
      last_contribution_date: last_contribution&.[](:date),
      last_grass_check_date: Time.current
    )
  end

  def last_contribution_day(data)
    data.reverse.find { |d| d[:count].to_i > 0 }
  end
end
