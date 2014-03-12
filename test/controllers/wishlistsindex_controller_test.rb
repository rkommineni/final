require 'test_helper'

class WishlistsindexControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get add" do
    get :add
    assert_response :success
  end

end
