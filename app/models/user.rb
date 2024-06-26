# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :societies, dependent: :destroy
  has_many :clients, through: :societies
  has_many :registers, through: :societies
  has_many :invoices, dependent: :destroy
end
