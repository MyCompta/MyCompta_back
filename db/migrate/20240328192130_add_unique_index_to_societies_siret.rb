# frozen_string_literal: true

class AddUniqueIndexToSocietiesSiret < ActiveRecord::Migration[7.1]
  def change
    add_index :societies, :siret, unique: true
  end
end
