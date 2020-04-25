require 'test_helper'

class ItemFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:ken)
    @room = rooms(:room1)
    @item = items(:meal)
    sign_in @user
  end

  test 'create item' do
    get room_url(@room)
    assert_response :success
    post items_path,
      params: {
        item: {
          value: 2500,
          category: '食費',
          user_id: @user.id,
          room_id: @room.id,
          date: '2020-04-20'
        }
      }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal '追加しました', flash[:notice]
    assert_select 'td', '2500円'
  end

  test 'update item' do
    get room_url(@room)
    assert_response :success
    assert_select 'td', '500円'
    get edit_room_item_url(@item, room_id: @room.id)
    assert_response :success
    patch item_url(@item),
      params: {
        item: {
          value: 1500,
          user_id: @user.id,
          room_id: @room.id
        }
      }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal '更新できました', flash[:notice]
    assert_select 'td', '1500円'
  end

  test 'destroy item' do
    get room_url(@room)
    assert_response :success
    assert_select 'td', '500円'
    delete item_url(@item, room_id: @room.id)
    assert_response :redirect
    follow_redirect!
    assert_equal '削除しました', flash[:notice]
  end

end
