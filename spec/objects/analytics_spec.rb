require "spec_helper"

describe Vhx::Analytics do
  describe ".report" do
    it "retrieves statistics from the /analytics endpoint" do
      Vhx.setup(test_credentials)
      payload = {
        "_links" => {
          "self" => { "href" => "/analytics" },
        },
        "to" => "to",
        "from" => "from",
        "type" => "type",
        "data" => {
          "plays" => 10,
          "seconds" => 60,
          "finishes" => 9,
          "video_id" => 1,
        }
      }
      query_params = {
        "page" => "1",
        "per_page" => "10",
      }
      stub_analytics(query_params: query_params, response: payload)

      analytics = Vhx::Analytics.report(query_params)

      expect(analytics.to).to eq(payload.fetch("to"))
      expect(analytics.from).to eq(payload.fetch("from"))
      expect(analytics.type).to eq(payload.fetch("type"))
      expect(analytics.data).to eq(payload.fetch("data"))
    end
  end

  def stub_analytics(response:, query_params:)
    stub_request(:get, %r{api.vhx.tv/analytics}).
      with(query: hash_including(query_params)).
      to_return(body: response.to_json)
  end
end
