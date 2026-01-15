module Api
  module V1
    class HealthController < PublicController
      def index
        render_success(data: { status: I18n.t("api.status.ok") })
      end
    end
  end
end
