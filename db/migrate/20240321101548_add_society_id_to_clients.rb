# frozen_string_literal: true

class AddSocietyIdToClients < ActiveRecord::Migration[7.1]
  def change
    add_reference :clients, :society, foreign_key: true
  end
end
