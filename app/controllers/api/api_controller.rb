module Api
  class ApiController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Pagination

    before_action :authenticate_user!

    protected

    def current_user
      current_api_v1_user
    end

    def authenticate_user!
      authenticate_api_v1_user!
    end
  end
end
