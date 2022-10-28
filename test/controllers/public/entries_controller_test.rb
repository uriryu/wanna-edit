require "test_helper"

class Public::EntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_entries_index_url
    assert_response :success
  end
end
