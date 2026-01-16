# frozen_string_literal: true

class Transaction < ApplicationRecord
  enum :kind, { income: 0, expense: 1 }

  belongs_to :user
  belongs_to :category

  monetize :amount_cents, with_currency: :currency

  validates :amount_cents, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true, length: { is: 3 }
  validates :kind, presence: true
  validates :occurred_at, presence: true
  validates :paid, inclusion: { in: [true, false] }
end
