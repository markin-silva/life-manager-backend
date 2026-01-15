# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Authentication", type: :request do
  describe "POST /api/v1/auth" do
    context "with valid params" do
      it "creates a user and returns auth headers" do
        params = {
          email: "new_user@example.com",
          password: "password123",
          password_confirmation: "password123"
        }

        post "/api/v1/auth", params: params

        expect(response).to have_http_status(:ok)
        expect(json).to include(
          "status" => "success",
          "data" => include("email" => params[:email])
        )
        expect(response.headers).to include("access-token", "client", "uid")
      end
    end

    context "with invalid params" do
      it "returns validation errors" do
        post "/api/v1/auth", params: { email: "", password: "short" }

        expect(response).to have_http_status(:unprocessable_content)
        expect(json["errors"]).to be_present
      end
    end

    context "without authentication" do
      it "allows signup without auth headers" do
        post "/api/v1/auth", params: {
          email: "public_signup@example.com",
          password: "password123",
          password_confirmation: "password123"
        }

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST /api/v1/auth/sign_in" do
    context "with valid credentials" do
      it "signs in and returns auth headers" do
        user = create(:user)

        post "/api/v1/auth/sign_in", params: { email: user.email, password: "password123" }

        expect(response).to have_http_status(:ok)
        expect(json).to include(
          "data" => include("email" => user.email)
        )
        expect(response.headers).to include("access-token", "client", "uid")
      end
    end

    context "with invalid credentials" do
      it "returns unauthorized" do
        user = create(:user)

        post "/api/v1/auth/sign_in", params: { email: user.email, password: "wrong" }

        expect(response).to have_http_status(:unauthorized)
        expect(json["errors"]).to be_present
      end
    end

    context "without authentication" do
      it "allows sign in without auth headers" do
        user = create(:user)

        post "/api/v1/auth/sign_in", params: { email: user.email, password: "password123" }

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE /api/v1/auth/sign_out" do
    context "with valid token" do
      it "signs out successfully" do
        user = create(:user)
        headers = login(user)

        delete "/api/v1/auth/sign_out", headers: headers

        expect(response).to have_http_status(:ok)
        expect(json).to include("success" => true)
      end
    end

    context "without authentication" do
      it "returns not found" do
        delete "/api/v1/auth/sign_out"

        expect(response).to have_http_status(:not_found)
      end
    end

    context "with invalid token" do
      it "returns not found" do
        user = create(:user)
        delete "/api/v1/auth/sign_out", headers: invalid_auth_headers(user)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
