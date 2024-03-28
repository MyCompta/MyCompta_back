# frozen_string_literal: true

class ChangeColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :societies, :adress, :address
    rename_column :invoices, :date, :issued_at
    rename_column :invoices, :due_date, :due_at
  end
end
