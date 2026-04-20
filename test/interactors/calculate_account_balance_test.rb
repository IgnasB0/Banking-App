require "test_helper"

class CalculateAccountBalanceTest < ActiveSupport::TestCase
  test "calculates balance from deposits, withdrawals and transfers" do
    account = accounts(:alice)
    # alice has: deposit 500, withdrawal 100, sent 50 to bob
    # expected balance: 500 - 100 - 50 = 350

    result = CalculateAccountBalance.call(account: account)

    assert result.success?
    assert_equal 350.0, result.balance.to_f
  end

  test "calculates balance including received transfers" do
    account = accounts(:bob)
    # bob has: received 50 from alice
    # expected balance: 50

    result = CalculateAccountBalance.call(account: account)

    assert result.success?
    assert_equal 50.0, result.balance.to_f
  end
end
