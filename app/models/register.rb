# frozen_string_literal: true

class Register < ApplicationRecord
  belongs_to :society
  belongs_to :invoice, optional: true
  delegate :user, to: :society
end
