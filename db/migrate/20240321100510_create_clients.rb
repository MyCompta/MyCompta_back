# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.text :address
      t.integer :zip
      t.string :city
      t.integer :siret
      t.boolean :is_pro, default: false, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
