class AddPersonnalInfoToClients < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :email, :string
    add_column :clients, :country, :string
  end
end
