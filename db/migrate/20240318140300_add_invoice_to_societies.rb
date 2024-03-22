class AddInvoiceToSocieties < ActiveRecord::Migration[7.1]
  def change
    add_reference :invoices, :society, foreign_key: true
  end
end
