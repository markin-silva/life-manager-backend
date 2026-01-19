# frozen_string_literal: true

class TransactionBlueprint < Blueprinter::Base
  identifier :id

  fields :kind, :description, :currency, :paid, :occurred_at, :created_at, :updated_at

  field :amount do |transaction|
    (transaction.amount_cents.to_d / 100).to_s("F")
  end

  association :category, blueprint: CategoryBlueprint
end
