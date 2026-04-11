require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  test "is valid with all required fields" do
    transaction = Transaction.new(
      from_account: accounts(:alice),
      to_account: accounts(:bob),
      amount: 25.00
    )
    assert transaction.valid?
  end

  test "is invalid without a from account" do
    transaction = Transaction.new(to_account: accounts(:bob), amount: 25.00)
    assert_not transaction.valid?
  end

  test "is invalid without a to account" do
    transaction = Transaction.new(from_account: accounts(:alice), amount: 25.00)
    assert_not transaction.valid?
  end
end
