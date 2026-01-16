# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :user, optional: true
  has_many :transactions, dependent: :nullify

  validates :key, presence: true, if: :system?
  validates :name, presence: true, unless: :system?
  validates :color, presence: true
  validates :icon, presence: true
  validates :system, inclusion: { in: [true, false] }

  validate :system_category_has_no_user
  validate :custom_category_requires_user

  private

  def system_category_has_no_user
    return unless system? && user.present?

    errors.add(:user_id, "must be nil for system categories")
  end

  def custom_category_requires_user
    return if system? || user.present?

    errors.add(:user_id, "must be present for custom categories")
  end
end
