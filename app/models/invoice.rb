# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :society
  belongs_to :client
  has_one :register, dependent: :destroy

  validates :category, presence: true, inclusion: { in: %w[invoice quotation] }
end
