require "test_helper"

class Admin::TransactionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_transaction_index_url
    assert_response :success
  end
end
