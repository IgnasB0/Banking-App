require "test_helper"

class BankingFacilityTest < ActiveSupport::TestCase
  test "is valid with all required fields" do
    facility = BankingFacility.new(
      name: "Main Branch",
      api_key_digest: Digest::SHA256.hexdigest("some_api_key")
    )
    assert facility.valid?
  end

  test "is invalid without a name" do
    facility = BankingFacility.new(api_key_digest: Digest::SHA256.hexdigest("some_api_key"))
    assert_not facility.valid?
  end
end
