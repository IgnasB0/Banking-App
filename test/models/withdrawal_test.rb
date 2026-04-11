require "test_helper"

class WithdrawalTest < ActiveSupport::TestCase
  test "is valid with all required fields" do
    withdrawal = Withdrawal.new(
      banking_facility: banking_facilities(:atm_one),
      account: accounts(:alice),
      amount: 50.00
    )
    assert withdrawal.valid?
  end

  test "is invalid without an account" do
    withdrawal = Withdrawal.new(banking_facility: banking_facilities(:atm_one), amount: 50.00)
    assert_not withdrawal.valid?
  end

  test "is invalid without a banking facility" do
    withdrawal = Withdrawal.new(account: accounts(:alice), amount: 50.00)
    assert_not withdrawal.valid?
  end
end
