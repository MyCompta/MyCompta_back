class ChangeColumnInvoiceUnit < ActiveRecord::Migration[7.1]
  def change
    change_column :invoices, :subtotal, :float
    change_column :invoices, :tva, :float
    change_column :invoices, :total, :float
    change_column :invoices, :sale, :float
  end
end
