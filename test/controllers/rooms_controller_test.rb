require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'can create a room' do
    sign_in users(:ken)
    assert_difference "Room.count", 1 do
      post rooms_url, params: { room: { name: 'test' } }
    end
    assert_redirected_to users(:ken)
  end

  test 'cannot create a room without name' do
    assert_no_difference "Room.count" do
      sign_in users(:ken)
      post rooms_url, params: { room: { name: '' } }
    end
  end

  test 'cannot create a room without login' do
    assert_no_difference "Room.count" do
      post rooms_url, params: { room: { name: '' } }
    end
    assert_redirected_to new_user_session_url
  end

  test 'can destroy a room' do
    sign_in users(:ken)
    @room = rooms(:room1)
    assert_difference "Room.count", -1 do
      delete room_path(@room)
    end
    assert_redirected_to root_url
  end

  test 'incorrect user cannot destroy a room' do
    sign_in users(:john)
    room = rooms(:room1)
    assert_no_difference "Room.count" do
      delete room_url(room)
    end
    assert_redirected_to users(:john)
  end

  test 'cannot destroy a room without login' do
    room = rooms(:room1)
    assert_no_difference "Room.count" do
      delete room_url(room)
    end
    assert_redirected_to new_user_session_url
  end
end
