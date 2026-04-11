class Withdrawal < ApplicationRecord
  belongs_to :banking_facility
  belongs_to :account
  validates :amount, presence: true
end
