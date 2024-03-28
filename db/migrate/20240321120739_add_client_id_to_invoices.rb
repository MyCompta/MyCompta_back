# frozen_string_literal: true

class AddClientIdToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_reference :invoices, :client, foreign_key: true
  end
end
