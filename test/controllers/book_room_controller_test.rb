require 'test_helper'

class BookRoomControllerTest < ActionDispatch::IntegrationTest
  test "should get book" do
    get book_room_book_url
    assert_response :success
  end

end
