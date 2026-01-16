# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories, id: :uuid do |t|
      t.references :user, type: :bigint, foreign_key: true, null: true
      t.string :key
      t.string :name
      t.string :color
      t.string :icon
      t.boolean :system, null: false, default: false

      t.timestamps
    end

    add_index :categories, :key, unique: true, where: "system = true"
    add_index :categories, %i[user_id system]
  end
end
