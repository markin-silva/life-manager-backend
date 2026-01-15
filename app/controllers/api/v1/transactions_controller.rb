# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApiController
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

        transaction.save!

        render_success(data: serialize(transaction), status: :created)
      end

      def update
        transaction = policy_scope(Transaction).find(params[:id])
        authorize transaction

        transaction.update!(transaction_params)

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
        params.require(:transaction).permit(:amount, :kind, :description, :category, :occurred_at)
      end

      def serialize(transaction)
        {
          id: transaction.id,
          amount: transaction.amount,
          kind: transaction.kind,
          description: transaction.description,
          category: transaction.category,
          occurred_at: transaction.occurred_at,
          created_at: transaction.created_at,
          updated_at: transaction.updated_at
        }
      end
    end
  end
end
