require "rails_helper"

RSpec.describe GithubService do
  let(:username) { "testuser" }
  let(:service)  { described_class.new(username) }
  let(:from)     { "2024-01-01T00:00:00Z" }
  let(:to)       { "2024-01-07T23:59:59Z" }

  let(:conn) { instance_double(Faraday::Connection) }

  before do
    allow(ENV).to receive(:fetch).with("GITHUB_TOKEN").and_return("dummy-token")
    allow(Faraday).to receive(:new).and_return(conn)
  end

  describe "#fetch_contributions" do
    context "正常なレスポンスの場合" do
      let(:response_body) do
        {
          data: {
            user: {
              contributionsCollection: {
                contributionCalendar: {
                  weeks: [
                    {
                      contributionDays: [
                        { date: "2024-01-01", contributionCount: 3 },
                        { date: "2024-01-02", contributionCount: 0 }
                      ]
                    }
                  ]
                }
              }
            }
          }
        }.to_json
      end

      it "日単位の配列を返す" do
        response = instance_double(
          Faraday::Response,
          success?: true,
          body: response_body
        )

        allow(conn).to receive(:post).and_return(response)

        result = service.fetch_contributions(from: from, to: to)

        expect(result).to eq(
          [
            { date: "2024-01-01", count: 3 },
            { date: "2024-01-02", count: 0 }
          ]
        )
      end
    end

    context "HTTPエラーの場合" do
      it "空配列を返す" do
        response = instance_double(
          Faraday::Response,
          success?: false,
          status: 500,
          body: "error"
        )

        allow(conn).to receive(:post).and_return(response)

        expect(
          service.fetch_contributions(from: from, to: to)
        ).to eq([])
      end
    end

    context "GraphQLエラーが含まれる場合" do
      it "空配列を返す" do
        response = instance_double(
          Faraday::Response,
          success?: true,
          body: { errors: ["something went wrong"] }.to_json
        )

        allow(conn).to receive(:post).and_return(response)

        expect(
          service.fetch_contributions(from: from, to: to)
        ).to eq([])
      end
    end

    context "タイムアウトが発生した場合" do
      it "空配列を返す" do
        allow(conn).to receive(:post).and_raise(Faraday::TimeoutError)

        expect(
          service.fetch_contributions(from: from, to: to)
        ).to eq([])
      end

      it "タイムアウト時に network error をログ出力する" do
        allow(conn).to receive(:post).and_raise(Faraday::TimeoutError)

        expect(Rails.logger).to receive(:error)
          .with(/Network error: Faraday::TimeoutError/)

        service.fetch_contributions(from: from, to: to)
      end
    end
  end
end
