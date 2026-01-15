# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Health", type: :request do
  describe "GET /api/v1/health" do
    it "returns ok status" do
      get "/api/v1/health"

      expect(response).to have_http_status(:ok)
      expect(json).to eq(
        "status" => I18n.t("api.status.success"),
        "data" => { "status" => I18n.t("api.status.ok") }
      )
    end
  end
end
