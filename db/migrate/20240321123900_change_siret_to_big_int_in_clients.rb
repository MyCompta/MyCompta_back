# frozen_string_literal: true

class ChangeSiretToBigIntInClients < ActiveRecord::Migration[7.1]
  def up
    change_column :clients, :siret, :bigint
  end

  def down
    change_column :clients, :siret, :integer
  end
end
