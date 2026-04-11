require "test_helper"

class CreateAccountTest < ActiveSupport::TestCase
  test "creates an account with a generated IBAN" do
    result = CreateAccount.call(account_params: { first_name: "Jane", last_name: "Doe", country_code: "GB" })

    assert result.success?
    assert_not_nil result.account.iban
    assert result.account.persisted?
  end

  test "fails with an unsupported country code" do
    result = CreateAccount.call(account_params: { first_name: "Jane", last_name: "Doe", country_code: "XX" })

    assert_not result.success?
  end
end
