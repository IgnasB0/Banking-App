require "test_helper"

class DepositsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get deposits_create_url
    assert_response :success
  end
end
