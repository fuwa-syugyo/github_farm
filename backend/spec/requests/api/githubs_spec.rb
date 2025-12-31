# spec/requests/api/githubs_spec.rb
require "rails_helper"

RSpec.describe "Api::Githubs", type: :request do
  describe "GET /api/github/contributions" do
    let(:user) { create(:user) }

    let(:mock_data) do
      [
        { date: "2024-01-01", count: 0 },
        { date: "2024-01-02", count: 3 },
        { date: "2024-01-03", count: 0 }
      ]
    end

    before do
      allow_any_instance_of(Api::GithubsController)
        .to receive(:current_user)
        .and_return(user)

      allow_any_instance_of(GithubService)
        .to receive(:fetch_contributions)
        .and_return(mock_data)
    end


    it "草データを返し、ユーザー情報を更新する" do
      get "/api/github/contributions",
      headers: {
        "Host" => "localhost",
        "Origin" => "http://localhost:3000"
      }

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json).to be_an(Array)
      expect(json.size).to eq 3

      user.reload
      expect(user.last_grass_check_date).not_to be_nil
      expect(user.last_contribution_date).to eq Date.new(2024, 1, 2)
    end
  end
end
