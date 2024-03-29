# frozen_string_literal: true

class Register < ApplicationRecord
  belongs_to :society
  belongs_to :invoice, optional: true
  delegate :user, to: :society

  validates :title, presence: true, length: { maximum: 255, minimum: 3 }
  validates :payment_method, presence: true
  validates :paid_at, presence: true
  validates :amount, presence: true
  validates :is_income, presence: true
end
