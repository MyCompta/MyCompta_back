# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :user
  belongs_to :society
  has_many :invoices, dependent: :destroy

  # validates :business_name, presence: true
  validates :address, presence: true
  validates :zip, presence: true, numericality: { only_integer: true }
  validates :city, presence: true
  validates :siret, numericality: { only_integer: true }, allow_nil: true
  validates :is_pro, inclusion: { in: [true, false] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t(:invalid_email_format) }, allow_nil: true
end
