class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :society
  belongs_to :client
end
