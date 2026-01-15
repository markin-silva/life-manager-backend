# frozen_string_literal: true

module AuthHelpers
  def auth_headers(user)
    user.create_new_auth_token
  end

  def login(user, password: "password123")
    post "/api/v1/auth/sign_in", params: { email: user.email, password: password }
    auth_headers_from(response)
  end

  def auth_headers_from(response)
    response.headers.slice("access-token", "client", "uid", "expiry", "token-type")
  end

  def invalid_auth_headers(user)
    {
      "access-token" => "invalid",
      "client" => "invalid",
      "uid" => user.uid
    }
  end
end
