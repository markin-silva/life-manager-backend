# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Transactions", type: :request do
  describe "GET /api/v1/transactions" do
    it "returns only transactions for the authenticated user" do
      user = create(:user)
      other_user = create(:user)
      create(:transaction, user: user)
      create(:transaction, user: user)
      create(:transaction, user: other_user)

      headers = auth_headers(user)

      get "/api/v1/transactions", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json["status"]).to eq("success")
      expect(json["data"].size).to eq(2)
    end
  end

  describe "POST /api/v1/transactions" do
    it "creates a transaction for the authenticated user" do
      user = create(:user)
      headers = auth_headers(user)
      payload = {
        transaction: {
          amount: 250.75,
          kind: "expense",
          description: "Groceries",
          category: "Food",
          occurred_at: Time.zone.now
        }
      }

      post "/api/v1/transactions", params: payload, headers: headers

      expect(response).to have_http_status(:created)
      expect(json["status"]).to eq("success")
      expect(json["data"]["amount"]).to eq("250.75")
      expect(json["data"]["kind"]).to eq("expense")
    end
  end

  describe "GET /api/v1/transactions/:id" do
    it "does not allow access to another user's transaction" do
      user = create(:user)
      other_user = create(:user)
      transaction = create(:transaction, user: other_user)

      headers = auth_headers(user)

      get "/api/v1/transactions/#{transaction.id}", headers: headers

      expect(response).to have_http_status(:not_found)
      expect(json["status"]).to eq("error")
    end
  end

  describe "PATCH /api/v1/transactions/:id" do
    it "does not allow updating another user's transaction" do
      user = create(:user)
      other_user = create(:user)
      transaction = create(:transaction, user: other_user)

      headers = auth_headers(user)

      patch "/api/v1/transactions/#{transaction.id}",
            params: { transaction: { description: "Hacked" } },
            headers: headers

      expect(response).to have_http_status(:not_found)
      expect(json["status"]).to eq("error")
    end
  end

  describe "DELETE /api/v1/transactions/:id" do
    it "does not allow deleting another user's transaction" do
      user = create(:user)
      other_user = create(:user)
      transaction = create(:transaction, user: other_user)

      headers = auth_headers(user)

      delete "/api/v1/transactions/#{transaction.id}", headers: headers

      expect(response).to have_http_status(:not_found)
      expect(json["status"]).to eq("error")
    end
  end
end
