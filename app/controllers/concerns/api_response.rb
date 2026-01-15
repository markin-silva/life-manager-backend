module ApiResponse
  def render_success(data:, meta: nil, status: :ok)
    payload = {
      status: I18n.t("api.status.success"),
      data: data
    }

    payload[:meta] = meta if meta.present?

    render json: payload, status: status
  end

  def render_error(code:, message:, status:, details: nil)
    payload = {
      status: I18n.t("api.status.error"),
      error: {
        code: code,
        message: message
      }
    }

    payload[:error][:details] = details if details.present?

    render json: payload, status: status
  end
end
