require "test_helper"

class EventContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get event_contacts_create_url
    assert_response :success
  end
end
