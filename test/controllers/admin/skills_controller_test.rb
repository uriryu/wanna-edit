require "test_helper"

class Admin::SkillsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_skills_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_skills_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_skills_edit_url
    assert_response :success
  end
end
