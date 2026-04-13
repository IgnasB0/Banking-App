require "test_helper"

class TransferTest < ActiveSupport::TestCase
  test "is valid with all required fields" do
    transfer = Transfer.new(
      from_account: accounts(:alice),
      to_account: accounts(:bob),
      amount: 25.00
    )
    assert transfer.valid?
  end

  test "is invalid without a from account" do
    transfer = Transfer.new(to_account: accounts(:bob), amount: 25.00)
    assert_not transfer.valid?
  end

  test "is invalid without a to account" do
    transfer = Transfer.new(from_account: accounts(:alice), amount: 25.00)
    assert_not transfer.valid?
  end
end
