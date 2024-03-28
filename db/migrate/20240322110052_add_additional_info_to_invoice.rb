# frozen_string_literal: true

class AddAdditionalInfoToInvoice < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :additional_info, :text
  end
end
