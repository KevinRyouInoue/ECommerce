require "test_helper"

class CartControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cart_index_url
    assert_response :success
  end

  test "should get add_item" do
    get cart_add_item_url
    assert_response :success
  end

  test "should get remove_item" do
    get cart_remove_item_url
    assert_response :success
  end

  test "should get update_quantity" do
    get cart_update_quantity_url
    assert_response :success
  end
end
