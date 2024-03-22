class Client < ApplicationRecord
  belongs_to :user
  belongs_to :society
  has_many :invoices

  validates :business_name, presence: true
  validates :address, presence: true
  validates :zip, presence: true, numericality: { only_integer: true }
  validates :city, presence: true
  validates :siret, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :is_pro, inclusion: { in: [true, false] }
  validates :user_id, presence: true
  validates :society_id, presence: true

end
