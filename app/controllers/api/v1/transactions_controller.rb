# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApiController
      def index
        transactions = policy_scope(Transaction)
                       .order(occurred_at: :desc)
                       .page(pagination_params[:page])
                       .per(pagination_params[:per_page])

        data = TransactionBlueprint.render_as_hash(transactions)

        render_success(data: data, meta: pagination_meta(transactions))
      end

      def show
        transaction = policy_scope(Transaction).find(params[:id])
        authorize transaction

        data = TransactionBlueprint.render_as_hash(transaction)

        render_success(data: data)
      end

      def create
        transaction = current_user.transactions.new(transaction_params)
        authorize transaction

        transaction.category = permitted_category
        transaction.save!

        data = TransactionBlueprint.render_as_hash(transaction)

        render_success(data: data, status: :created)
      end

      def update
        transaction = policy_scope(Transaction).find(params[:id])
        authorize transaction

        transaction.assign_attributes(transaction_params)
        transaction.category = permitted_category if transaction_params[:category_id].present?
        transaction.save!

        data = TransactionBlueprint.render_as_hash(transaction)

        render_success(data: data)
      end

      def destroy
        transaction = policy_scope(Transaction).find(params[:id])
        authorize transaction

        transaction.destroy!

        render_success(data: { id: transaction.id })
      end

      private

      def transaction_params
        params.permit(:amount, :currency, :paid, :kind, :description, :category_id, :occurred_at)
      end

      def permitted_category
        return if transaction_params[:category_id].blank?

        policy_scope(Category).find(transaction_params[:category_id])
      end
    end
  end
end
