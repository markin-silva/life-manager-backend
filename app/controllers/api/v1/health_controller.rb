module Api
  module V1
    class HealthController < PublicController
      def index
        render json: { status: "ok" }
      end
    end
  end
end
