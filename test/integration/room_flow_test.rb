require 'test_helper'

class RoomFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:ken)
    @room = rooms(:room1)
    @other_user = users(:john)
    @invited_user = users(:maeda)
    @invite = invites(:one)
    sign_in @user
  end

  test 'create room' do
    get root_url
    assert_select 'a', @room.name.to_s
    get new_room_url
    assert_response :success
    post rooms_url,
      params: {
        room: {
          name: 'test'
        }
      }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal '新しい家計簿を作りました', flash[:notice]
    assert_select 'a', 'test'
  end

  test 'update room' do
    get root_url
    assert_select 'a', @room.name.to_s
    get edit_room_url(@room)
    assert_response :success
    patch room_url(@room),
      params: {
        room: {
          name: 'test'
        }
      }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal '名前を変更しました', flash[:notice]
    assert_select 'a', 'test'
  end

  test 'destroy room' do
    get root_url
    assert_select 'a', @room.name.to_s
    delete room_url(@room)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal '家計簿を削除しました', flash[:notice]
  end

  test 'join the room' do
    sign_in @invited_user
    get root_url
    assert_select 'div.content', "#{@room.name}に#{@user.name}さんから招待されました"
    assert_select 'a.btn_join_room', '参加'
    post rooms_add_invite_url(@invite)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal '参加しました', flash[:notice]
  end
end
