# frozen_string_literal: true

module Pagination
  MAX_PER_PAGE = 30

  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      total_count: collection.total_count,
      per_page: collection.limit_value
    }
  end

  def pagination_params
    default_per_page = MAX_PER_PAGE
    per_page = params[:per_page].presence || default_per_page
    per_page = [per_page.to_i, 1].max

    {
      page: (params[:page].presence || 1).to_i,
      per_page: [per_page, MAX_PER_PAGE].min
    }
  end
end