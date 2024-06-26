# frozen_string_literal: true

class Society < ApplicationRecord
  belongs_to :user
  has_many :invoices, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :registers, dependent: :destroy

  validates :name, presence: true, length: { in: 2..50 }
  validates :address, presence: true, length: { in: 2..50 }
  validates :zip, presence: true, length: { in: 3..10 }
  validates :city, presence: true, length: { in: 2..60 }
  validates :country, presence: true, length: { in: 3..60 }
  validates :siret, presence: true, numericality: { only_integer: true }, uniqueness: true
  validates :status, presence: true
  validates :capital, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t(:invalid_email_format) }
end
