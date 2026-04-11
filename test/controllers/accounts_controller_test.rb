require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "creates an account" do
    post accounts_url, params: { account: { first_name: "Jane", last_name: "Doe", country_code: "GB" } }

    assert_response :created
    assert_not_nil JSON.parse(response.body)["iban"]
  end

  test "returns account with balance" do
    account = accounts(:alice)
    get account_url(account)

    assert_response :success
    body = JSON.parse(response.body)
    assert_equal account.first_name, body["first_name"]
    assert_not_nil body["balance"]
  end
end
