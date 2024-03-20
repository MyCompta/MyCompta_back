class AddNumberToInvoice < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :number, :string
  end
end
