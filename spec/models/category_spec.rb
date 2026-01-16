# frozen_string_literal: true

require "rails_helper"

RSpec.describe Category, type: :model do
  describe "validations" do
    it "is valid with factory defaults" do
      category = build(:category)

      expect(category).to be_valid
    end

    it "requires name for custom categories" do
      category = build(:category, name: nil, system: false)

      expect(category).not_to be_valid
    end

    it "requires key for system categories" do
      category = build(:category, key: nil, system: true, user: nil)

      expect(category).not_to be_valid
    end

    it "requires user for custom categories" do
      category = build(:category, user: nil, system: false)

      expect(category).not_to be_valid
    end

    it "requires no user for system categories" do
      category = build(:category, user: create(:user), system: true, key: "food", name: nil)

      expect(category).not_to be_valid
    end

    it "requires color" do
      category = build(:category, color: nil)

      expect(category).not_to be_valid
    end

    it "requires icon" do
      category = build(:category, icon: nil)

      expect(category).not_to be_valid
    end
  end
end
