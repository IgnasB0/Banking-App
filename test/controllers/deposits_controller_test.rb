require "test_helper"

class DepositsControllerTest < ActionDispatch::IntegrationTest
  test "creates a deposit with valid api key" do
    post deposits_url,
         params: { account_id: accounts(:alice).id, amount: 200.00 },
         headers: { "Authorization" => "Bearer test_api_key" }

    assert_response :created
    body = JSON.parse(response.body)
    assert_equal "200.0", body["amount"]
  end

  test "returns unauthorized with invalid api key" do
    post deposits_url,
         params: { account_id: accounts(:alice).id, amount: 200.00 },
         headers: { "Authorization" => "Bearer wrong_key" }

    assert_response :unauthorized
  end

  test "returns unauthorized with missing api key" do
    post deposits_url,
         params: { account_id: accounts(:alice).id, amount: 200.00 }

    assert_response :unauthorized
  end
end
