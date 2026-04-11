require "test_helper"

class DepositTest < ActiveSupport::TestCase
  test "is valid with all required fields" do
    deposit = Deposit.new(
      banking_facility: banking_facilities(:atm_one),
      account: accounts(:alice),
      amount: 100.00
    )
    assert deposit.valid?
  end

  test "is invalid without an account" do
    deposit = Deposit.new(banking_facility: banking_facilities(:atm_one), amount: 100.00)
    assert_not deposit.valid?
  end

  test "is invalid without a banking facility" do
    deposit = Deposit.new(account: accounts(:alice), amount: 100.00)
    assert_not deposit.valid?
  end
end
