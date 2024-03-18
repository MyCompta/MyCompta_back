# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :societie,s dependent: :destroy
  has_many :invoices, dependent: :destroy
end
