require 'test_helper'

class BookControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get comment" do
    get :comment
    assert_response :success
  end

end
