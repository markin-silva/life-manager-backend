# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, null: false, precision: 12, scale: 2
      t.integer :kind, null: false
      t.string :description
      t.string :category
      t.datetime :occurred_at, null: false

      t.timestamps
    end

    add_index :transactions, :occurred_at
    add_index :transactions, :kind
    add_index :transactions, %i[user_id occurred_at]
  end
end
