require "test_helper"

class Admin::WorksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_works_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_works_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_works_edit_url
    assert_response :success
  end
end
