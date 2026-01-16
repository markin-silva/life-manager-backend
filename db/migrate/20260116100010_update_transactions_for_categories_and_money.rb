# frozen_string_literal: true

class UpdateTransactionsForCategoriesAndMoney < ActiveRecord::Migration[7.2]
  def up
    change_table :transactions, bulk: true do |t|
      t.references :category, type: :uuid, foreign_key: true
      t.integer :amount_cents, null: false, default: 0
      t.string :currency, null: false, default: "BRL"
      t.boolean :paid, null: false, default: true
      t.remove :amount, :category
    end

    add_index :transactions, :paid
    add_index :transactions, :currency
  end

  def down
    remove_index :transactions, :currency
    remove_index :transactions, :paid

    change_table :transactions, bulk: true do |t|
      t.decimal :amount, precision: 12, scale: 2
      t.string :category
      t.remove :category_id
      t.remove :amount_cents
      t.remove :currency
      t.remove :paid
    end
  end
end
