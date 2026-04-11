require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "creates a transaction" do
    post transactions_url, params: {
      transaction: {
        from_account_id: accounts(:alice).id,
        to_account_id: accounts(:bob).id,
        amount: 25.00
      }
    }

    assert_response :created
  end
end
