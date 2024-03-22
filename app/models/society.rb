class Society < ApplicationRecord
  belongs_to :user
  has_many :invoices
  has_many :clients

  validates :name, presence: true
  validates :adress, presence: true
  validates :zip, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :siret, presence: true, numericality: { only_integer: true}, uniqueness: true
  validates :status, presence: true
  validates :capital, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "format is invalid" }
  validates :user_id, presence: true

end
