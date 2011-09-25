require 'test_helper'

class ConfigControllerTest < ActionController::TestCase
  test "should get week" do
    get :week
    assert_response :success
  end

  test "should get picks" do
    get :picks
    assert_response :success
  end

end
