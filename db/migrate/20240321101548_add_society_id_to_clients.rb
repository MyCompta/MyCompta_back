class AddSocietyIdToClients < ActiveRecord::Migration[7.1]
  def change
    add_reference :clients, :society, null: false, foreign_key: true
  end
end
