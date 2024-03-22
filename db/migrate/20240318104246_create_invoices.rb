class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :content
      t.timestamp :date
      t.timestamp :due_date
      t.string :title
      t.integer :subtotal
      t.integer :tva
      t.integer :total
      t.integer :sale
      t.boolean :is_draft
      t.boolean :is_paid
      t.text :status

      t.timestamps
    end
  end
end
