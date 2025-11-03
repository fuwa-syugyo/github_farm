# app/services/github_service.rb
require "faraday"
require "json"

class GithubService
  GITHUB_GRAPHQL_ENDPOINT = "https://api.github.com/graphql"

  def initialize(username)
    @username = username
    @token = ENV.fetch("GITHUB_TOKEN")
  end

  # from, to: "YYYY-MM-DD" 形式の文字列
  def fetch_contributions(from:, to:)
    query = <<~GRAPHQL
      query($user: String!, $from: DateTime!, $to: DateTime!) {
        user(login: $user) {
          contributionsCollection(from: $from, to: $to) {
            contributionCalendar {
              totalContributions
              weeks {
                contributionDays {
                  date
                  contributionCount
                }
              }
            }
          }
        }
      }
    GRAPHQL

    variables = { user: @username, from:, to: }

    response = Faraday.post(GITHUB_GRAPHQL_ENDPOINT) do |req|
      req.headers["Authorization"] = "Bearer #{@token}"
      req.headers["Content-Type"] = "application/json"
      req.body = { query:, variables: }.to_json
    end

    body = JSON.parse(response.body)

    if body["errors"]
      Rails.logger.error("[GithubService] Error: #{body['errors']}")
      return []
    end

    # 日単位のデータを展開
    weeks = body.dig("data", "user", "contributionsCollection", "contributionCalendar", "weeks") || []
    days = weeks.flat_map do |week|
      week["contributionDays"].map do |day|
        {
          date: day["date"],
          count: day["contributionCount"]
        }
      end
    end

    days
  end
end
