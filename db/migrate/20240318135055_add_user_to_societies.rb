# frozen_string_literal: true

class AddUserToSocieties < ActiveRecord::Migration[7.1]
  def change
    add_reference :societies, :user, foreign_key: true
  end
end
