require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get contacts_show_url
    assert_response :success
  end
end
