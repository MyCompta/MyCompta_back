# frozen_string_literal: true

class ChangeColumnInvoiceUnit < ActiveRecord::Migration[7.1]
  def up
    change_table :invoices, bulk: true do |t|
      t.float :subtotal
      t.float :tva
      t.float :total
      t.float :sale
    end
  end

  def down
    change_table :invoices, bulk: true do |t|
      t.integer :subtotal
      t.integer :tva
      t.integer :total
      t.integer :sale
    end
  end
end
