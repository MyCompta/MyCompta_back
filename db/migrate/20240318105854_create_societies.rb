class CreateSocieties < ActiveRecord::Migration[7.1]
  def change
    create_table :societies do |t|
      t.string :name
      t.string :adress
      t.integer :zip
      t.string :city
      t.string :country
      t.integer :siret
      t.string :status
      t.integer :capital
      t.string :email

      t.timestamps
    end
  end
end
