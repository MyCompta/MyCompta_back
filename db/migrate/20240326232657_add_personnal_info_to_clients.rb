# frozen_string_literal: true

class AddPersonnalInfoToClients < ActiveRecord::Migration[7.1]
  def change
    change_table :clients, bulk: true do |t|
      t.string :email
      t.string :country
    end
  end
end
