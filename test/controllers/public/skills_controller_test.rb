require "test_helper"

class Public::SkillsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_skills_new_url
    assert_response :success
  end

  test "should get index" do
    get public_skills_index_url
    assert_response :success
  end

  test "should get show" do
    get public_skills_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_skills_edit_url
    assert_response :success
  end
end
