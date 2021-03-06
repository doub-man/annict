# frozen_string_literal: true

describe "Api::V1::Records" do
  let(:access_token) { create(:oauth_access_token) }
  let(:user) { create(:user, :with_profile) }
  let(:work) { create(:work, :with_current_season) }
  let(:episode) { create(:episode, work: work) }
  let!(:record) { create(:checkin, work: work, episode: episode, user: user) }

  describe "GET /v1/records" do
    before do
      get api("/v1/records", access_token: access_token.token)
    end

    context "パラメータを渡さないとき" do
      it "200が返ること" do
        expect(response.status).to eq(200)
      end

      it "作品情報が取得できること" do
        expect(json["records"][0]["id"]).to eq(record.id)
        expect(json["total_count"]).to eq(1)
      end
    end
  end
end
