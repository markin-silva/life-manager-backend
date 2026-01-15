class ApplicationController < ActionController::API
  include ApiResponse
  include Pundit::Authorization

  before_action :set_locale

  rescue_from StandardError, with: :render_internal_error
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from Pundit::NotAuthorizedError, with: :render_forbidden

  private

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    header = request.headers["Accept-Language"].to_s
    return if header.blank?

    requested = header.split(",").map { |part| part.split(";").first.strip }
    requested.each do |locale|
      normalized = normalize_locale(locale)
      return normalized.to_sym if I18n.available_locales.map(&:to_s).include?(normalized)
    end

    nil
  end

  def normalize_locale(locale)
    parts = locale.split("-")
    return locale.downcase if parts.length == 1

    "#{parts[0].downcase}-#{parts[1].upcase}"
  end

  def render_forbidden
    render_error(
      code: I18n.t("errors.forbidden.code"),
      message: I18n.t("pundit.not_authorized"),
      status: :forbidden
    )
  end

  def render_not_found
    render_error(
      code: I18n.t("errors.not_found.code"),
      message: I18n.t("errors.not_found.message"),
      status: :not_found
    )
  end

  def render_unprocessable_entity(exception)
    render_error(
      code: I18n.t("errors.unprocessable.code"),
      message: I18n.t("errors.unprocessable.message"),
      status: :unprocessable_entity,
      details: exception.record.errors.to_hash
    )
  end

  def render_internal_error(exception)
    Rails.logger.error(exception)
    render_error(
      code: I18n.t("errors.internal.code"),
      message: I18n.t("errors.internal.message"),
      status: :internal_server_error
    )
  end
end
