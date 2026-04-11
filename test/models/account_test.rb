require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "is valid with all required fields" do
    account = Account.new(first_name: "Jane", last_name: "Doe", country_code: "GB", iban: "GB99TRMG99999999999999")
    assert account.valid?
  end

  test "iban must be unique" do
    existing = accounts(:alice)
    account = Account.new(first_name: "Jane", last_name: "Doe", country_code: "GB", iban: existing.iban)
    assert_not account.valid?
  end
end
