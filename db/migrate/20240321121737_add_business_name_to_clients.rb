# frozen_string_literal: true

class AddBusinessNameToClients < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :business_name, :string
  end
end
