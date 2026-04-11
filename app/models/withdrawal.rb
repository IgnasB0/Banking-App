class Withdrawal < ApplicationRecord
  belongs_to :banking_facility
  belongs_to :account
end
