# frozen_string_literal: true

class CreateRegisters < ActiveRecord::Migration[7.1]
  def change
    create_table :registers do |t|
      t.datetime :paid_at
      t.references :society, null: false, foreign_key: true
      t.references :invoice, null: true, foreign_key: true
      t.float :amount
      t.text :title
      t.text :comment
      t.string :payment_method
      t.boolean :is_income, null: false, default: false

      t.timestamps
    end
  end
end
