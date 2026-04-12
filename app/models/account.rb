class Account < ApplicationRecord
  belongs_to :user, optional: true
  validates :iban, uniqueness: true, allow_nil: true
end
