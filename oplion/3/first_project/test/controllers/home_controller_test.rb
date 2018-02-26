require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get attack" do
    get home_attack_url
    assert_response :success
  end

  test "should get defense" do
    get home_defense_url
    assert_response :success
  end

end
