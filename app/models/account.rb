class Account < ApplicationRecord
  validates :iban, uniqueness: true, allow_nil: true
end
