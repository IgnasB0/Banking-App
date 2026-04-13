require "test_helper"

class TransfersControllerTest < ActionDispatch::IntegrationTest
  test "creates a transfer" do
    post transfers_url, params: {
      transfer: {
        from_account_id: accounts(:alice).id,
        to_iban: accounts(:bob).iban,
        amount: 25.00
      }
    }

    assert_response :redirect
  end
end
