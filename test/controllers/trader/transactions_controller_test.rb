require "test_helper"

class Trader::TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trader_transactions_index_url
    assert_response :success
  end

  test "should get show" do
    get trader_transactions_show_url
    assert_response :success
  end

  test "should get new" do
    get trader_transactions_new_url
    assert_response :success
  end

  test "should get create" do
    get trader_transactions_create_url
    assert_response :success
  end
end
