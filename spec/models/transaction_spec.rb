# frozen_string_literal: true

require "rails_helper"

RSpec.describe Transaction, type: :model do
  describe "validations" do
    it "is valid with factory defaults" do
      transaction = build(:transaction)

      expect(transaction).to be_valid
    end

    it "requires amount" do
      transaction = build(:transaction, amount_cents: nil, currency: "BRL")

      expect(transaction).not_to be_valid
    end

    it "requires currency" do
      transaction = build(:transaction, currency: nil)

      expect(transaction).not_to be_valid
    end

    it "requires kind" do
      transaction = build(:transaction, kind: nil)

      expect(transaction).not_to be_valid
    end

    it "requires occurred_at" do
      transaction = build(:transaction, occurred_at: nil)

      expect(transaction).not_to be_valid
    end

    it "requires paid to be boolean" do
      transaction = build(:transaction, paid: nil)

      expect(transaction).not_to be_valid
    end

    it "requires category" do
      transaction = build(:transaction, category: nil)

      expect(transaction).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to user" do
      user = create(:user)
      transaction = create(:transaction, user: user)

      expect(transaction.user).to eq(user)
    end

    it "belongs to category" do
      category = create(:category)
      transaction = create(:transaction, category: category)

      expect(transaction.category).to eq(category)
    end
  end

  describe "enum" do
    it "supports income and expense" do
      income = build(:transaction, kind: :income)
      expense = build(:transaction, kind: :expense)

      expect(income).to be_income
      expect(expense).to be_expense
    end
  end
end
