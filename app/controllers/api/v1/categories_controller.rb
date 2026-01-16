# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApiController
      include CategorySerialization

      def index
        categories = policy_scope(Category).order(:system, :key, :name)

        render_success(data: categories.map { |category| serialize(category) })
      end

      def create
        category = current_user.categories.new(category_params)
        authorize category

        category.save!

        render_success(data: serialize(category), status: :created)
      end

      def update
        category = policy_scope(Category).find(params[:id])
        authorize category

        category.update!(category_params)

        render_success(data: serialize(category))
      end

      def destroy
        category = policy_scope(Category).find(params[:id])
        authorize category

        category.destroy!

        render_success(data: { id: category.id })
      end

      private

      def category_params
        params.require(:category).permit(:name, :color, :icon)
      end

      def serialize(category)
        serialize_category(category)
      end
    end
  end
end
