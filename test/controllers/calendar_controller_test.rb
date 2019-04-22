require 'test_helper'

class CalendarControllerTest < ActionDispatch::IntegrationTest
  test "should get calendar" do
    get calendar_calendar_url
    assert_response :success
  end

end
