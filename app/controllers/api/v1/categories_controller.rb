# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApiController
      def index
        categories = policy_scope(Category).order(:system, :key, :name)

        data = CategoryBlueprint.render_as_hash(categories)

        render_success(data: data)
      end

      def create
        category = current_user.categories.new(category_params)
        authorize category

        category.save!

        data = CategoryBlueprint.render_as_hash(category)

        render_success(data: data, status: :created)
      end

      def update
        category = policy_scope(Category).find(params[:id])
        authorize category

        category.update!(category_params)

        data = CategoryBlueprint.render_as_hash(category)

        render_success(data: data)
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

    end
  end
end
