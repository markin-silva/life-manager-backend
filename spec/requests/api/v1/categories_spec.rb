# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Categories", type: :request do
  describe "GET /api/v1/categories" do
    it "returns system and user categories" do
      user = create(:user)
      system_category = create(:category, :system)
      user_category = create(:category, user: user)
      create(:category, user: create(:user))

      headers = auth_headers(user)

      get "/api/v1/categories", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json["status"]).to eq("success")
      expect(json["data"]).to include(include("id" => system_category.id))
      expect(json["data"]).to include(include("id" => user_category.id))
      expect(json["data"]).to include(include("key" => system_category.key))
    end
  end

  describe "POST /api/v1/categories" do
    it "creates a custom category" do
      user = create(:user)
      headers = auth_headers(user)
      payload = {
        category: {
          name: "My Category",
          color: "#123456",
          icon: "tag"
        }
      }

      post "/api/v1/categories", params: payload, headers: headers

      expect(response).to have_http_status(:created)
      expect(json["status"]).to eq("success")
      expect(json["data"]["name"]).to eq("My Category")
    end
  end

  describe "PUT /api/v1/categories/:id" do
    it "prevents renaming system categories" do
      user = create(:user)
      category = create(:category, :system, color: "#111111")
      headers = auth_headers(user)
      payload = { category: { name: "Changed", color: "#222222" } }

      put "/api/v1/categories/#{category.id}", params: payload, headers: headers

      expect(response).to have_http_status(:forbidden)
      expect(json["status"]).to eq("error")
    end

    it "updates custom categories" do
      user = create(:user)
      category = create(:category, user: user, name: "Old")
      headers = auth_headers(user)

      put "/api/v1/categories/#{category.id}",
          params: { category: { name: "New" } },
          headers: headers

      expect(response).to have_http_status(:ok)
      expect(json["data"]["name"]).to eq("New")
    end
  end

  describe "DELETE /api/v1/categories/:id" do
    it "prevents deleting system categories" do
      user = create(:user)
      category = create(:category, :system)
      headers = auth_headers(user)

      delete "/api/v1/categories/#{category.id}", headers: headers

      expect(response).to have_http_status(:forbidden)
      expect(json["status"]).to eq("error")
    end

    it "deletes custom categories" do
      user = create(:user)
      category = create(:category, user: user)
      headers = auth_headers(user)

      delete "/api/v1/categories/#{category.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json["status"]).to eq("success")
    end
  end
end
