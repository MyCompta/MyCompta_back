class ChangeSiretToBigIntInClients < ActiveRecord::Migration[7.1]
  def change
    change_column :clients, :siret, :bigint
  end
end
