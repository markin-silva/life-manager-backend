# frozen_string_literal: true

class Transaction < ApplicationRecord
  enum :kind, { income: 0, expense: 1 }

  belongs_to :user

  validates :amount, presence: true, numericality: true
  validates :kind, presence: true
  validates :occurred_at, presence: true
end
