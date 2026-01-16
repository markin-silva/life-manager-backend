# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApiController
      include CategorySerialization

      def index
        transactions = policy_scope(Transaction).order(occurred_at: :desc)

        render_success(data: transactions.map { |transaction| serialize(transaction) })
      end

      def show
        transaction = policy_scope(Transaction).find(params[:id])
        authorize transaction

        render_success(data: serialize(transaction))
      end

      def create
        transaction = current_user.transactions.new(transaction_params)
        authorize transaction

        transaction.category = permitted_category
        transaction.save!

        render_success(data: serialize(transaction), status: :created)
      end

      def update
        transaction = policy_scope(Transaction).find(params[:id])
        authorize transaction

        transaction.assign_attributes(transaction_params)
        transaction.category = permitted_category if transaction_params[:category_id].present?
        transaction.save!

        render_success(data: serialize(transaction))
      end

      def destroy
        transaction = policy_scope(Transaction).find(params[:id])
        authorize transaction

        transaction.destroy!

        render_success(data: { id: transaction.id })
      end

      private

      def transaction_params
        params.require(:transaction).permit(:amount, :currency, :paid, :kind, :description, :category_id, :occurred_at)
      end

      def serialize(transaction)
        {
          id: transaction.id,
          amount: formatted_amount(transaction),
          currency: transaction.currency,
          paid: transaction.paid,
          kind: transaction.kind,
          description: transaction.description,
          category: serialize_category(transaction.category),
          occurred_at: transaction.occurred_at,
          created_at: transaction.created_at,
          updated_at: transaction.updated_at
        }
      end

      def formatted_amount(transaction)
        (BigDecimal(transaction.amount_cents) / 100).to_s("F")
      end

      def permitted_category
        return if transaction_params[:category_id].blank?

        policy_scope(Category).find(transaction_params[:category_id])
      end
    end
  end
end
