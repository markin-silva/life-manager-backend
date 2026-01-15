# frozen_string_literal: true

require "rails_helper"

RSpec.describe TransactionPolicy, type: :policy do
  describe "permissions" do
    it "allows access to owner" do
      user = create(:user)
      transaction = create(:transaction, user: user)

      policy = described_class.new(user, transaction)

      expect(policy.show?).to be(true)
      expect(policy.update?).to be(true)
      expect(policy.destroy?).to be(true)
    end

    it "denies access to other users" do
      user = create(:user)
      other_user = create(:user)
      transaction = create(:transaction, user: other_user)

      policy = described_class.new(user, transaction)

      expect(policy.show?).to be(false)
      expect(policy.update?).to be(false)
      expect(policy.destroy?).to be(false)
    end
  end

  describe "scope" do
    it "returns only user transactions" do
      user = create(:user)
      other_user = create(:user)
      owned = create(:transaction, user: user)
      create(:transaction, user: other_user)

      scope = described_class::Scope.new(user, Transaction).resolve

      expect(scope).to contain_exactly(owned)
    end
  end
end
