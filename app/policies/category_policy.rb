# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    return false if user.blank?
    return false if record.system?

    record.user_id == user.id
  end

  def destroy?
    return false if user.blank?
    return false if record.system?

    record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.where("user_id = ? OR system = ?", user.id, true)
    end
  end
end
