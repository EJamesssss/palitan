require "application_system_test_case"

class UserwalletsTest < ApplicationSystemTestCase
  setup do
    @userwallet = userwallets(:one)
  end

  test "visiting the index" do
    visit userwallets_url
    assert_selector "h1", text: "Userwallets"
  end

  test "creating a Userwallet" do
    visit userwallets_url
    click_on "New Userwallet"

    fill_in "Amount", with: @userwallet.amount
    fill_in "User", with: @userwallet.user_id
    click_on "Create Userwallet"

    assert_text "Userwallet was successfully created"
    click_on "Back"
  end

  test "updating a Userwallet" do
    visit userwallets_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @userwallet.amount
    fill_in "User", with: @userwallet.user_id
    click_on "Update Userwallet"

    assert_text "Userwallet was successfully updated"
    click_on "Back"
  end

  test "destroying a Userwallet" do
    visit userwallets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Userwallet was successfully destroyed"
  end
end
