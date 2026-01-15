module Api
  class ApiController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Pundit::Authorization

    before_action :authenticate_user!

    rescue_from Pundit::NotAuthorizedError, with: :render_forbidden

    protected

    def current_user
      current_api_v1_user
    end

    def authenticate_user!
      authenticate_api_v1_user!
    end

    private

    def render_forbidden
      render json: {
        status: "error",
        error: {
          code: "forbidden",
          message: "You are not authorized to perform this action."
        }
      }, status: :forbidden
    end
  end
end