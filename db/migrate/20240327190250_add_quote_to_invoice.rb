class AddQuoteToInvoice < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :category, :string, default: "invoice"
  end
end
