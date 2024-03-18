class Society < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :invoices

  validates :name, presence: true
  validates :adress, presence: true
  validates :zip, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :siret, presence: true, numericality: { only_integer: true}, length: { is: 13 }, uniqueness: true
  validates :status, presence: true
  validates :capital, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "format is invalid" }
  validates :user_id, presence: true

end
