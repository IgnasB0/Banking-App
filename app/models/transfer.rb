class Transfer < ApplicationRecord
  belongs_to :from_account, class_name: "Account"
  belongs_to :to_account, class_name: "Account"
  validates :amount, presence: true
  validate :accounts_must_differ

  private

  def accounts_must_differ
    errors.add(:to_account, "must be different from the sender account") if from_account_id == to_account_id
  end
end
