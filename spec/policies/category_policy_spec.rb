# frozen_string_literal: true

require "rails_helper"

RSpec.describe CategoryPolicy, type: :policy do
  describe "permissions" do
    it "denies update for system categories" do
      user = create(:user)
      category = create(:category, :system)

      policy = described_class.new(user, category)

      expect(policy.update?).to be(false)
      expect(policy.destroy?).to be(false)
    end

    it "allows owner to manage custom categories" do
      user = create(:user)
      category = create(:category, user: user)

      policy = described_class.new(user, category)

      expect(policy.update?).to be(true)
      expect(policy.destroy?).to be(true)
    end

    it "denies access to other users' categories" do
      user = create(:user)
      other_user = create(:user)
      category = create(:category, user: other_user)

      policy = described_class.new(user, category)

      expect(policy.update?).to be(false)
      expect(policy.destroy?).to be(false)
    end
  end

  describe "scope" do
    it "returns system and user categories" do
      user = create(:user)
      create(:category, :system)
      own = create(:category, user: user)
      create(:category, user: create(:user))

      scope = described_class::Scope.new(user, Category).resolve

      expect(scope).to include(own)
      expect(scope).to include(Category.find_by(system: true))
    end
  end
end
