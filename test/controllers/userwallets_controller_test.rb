require "test_helper"

class UserwalletsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @userwallet = userwallets(:one)
  end

  test "should get index" do
    get userwallets_url
    assert_response :success
  end

  test "should get new" do
    get new_userwallet_url
    assert_response :success
  end

  test "should create userwallet" do
    assert_difference('Userwallet.count') do
      post userwallets_url, params: { userwallet: { amount: @userwallet.amount, user_id: @userwallet.user_id } }
    end

    assert_redirected_to userwallet_url(Userwallet.last)
  end

  test "should show userwallet" do
    get userwallet_url(@userwallet)
    assert_response :success
  end

  test "should get edit" do
    get edit_userwallet_url(@userwallet)
    assert_response :success
  end

  test "should update userwallet" do
    patch userwallet_url(@userwallet), params: { userwallet: { amount: @userwallet.amount, user_id: @userwallet.user_id } }
    assert_redirected_to userwallet_url(@userwallet)
  end

  test "should destroy userwallet" do
    assert_difference('Userwallet.count', -1) do
      delete userwallet_url(@userwallet)
    end

    assert_redirected_to userwallets_url
  end
end
