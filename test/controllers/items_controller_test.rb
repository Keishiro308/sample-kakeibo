require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:ken)
    @room = rooms(:room1)
    @other_user = users(:john)
  end

  test 'can create an item with login' do
    sign_in @user
    assert_difference 'Item.count', 1 do
      post items_url, 
      params:{ item: {
        value: 500,
        user_id: @user.id,
        room_id: @room.id,
        category: '食費',
        date: '2020-04-12'
       } }
    end
  end

  test 'cannot create an item without login' do
    assert_no_difference 'Item.count' do
      post items_url, 
      params:{ item: {
        value: 500,
        user_id: @user.id,
        room_id: @room.id,
        category: '食費',
        date: '2020-04-12'
       } }
    end
  end

  test 'other user cannot create an item' do
    sign_in @other_user
    assert_no_difference 'Item.count' do
      post items_url, 
      params:{ item: {
        value: 500,
        user_id: @user.id,
        room_id: @room.id,
        category: '食費',
        date: '2020-04-12'
       } }
    end
    assert_redirected_to @other_user
  end

  test 'cannot create an item with invalid parameter' do
    sign_in @user
    assert_no_difference 'Item.count' do
      post items_url, 
      params:{ item: {
        value: 500,
        user_id: '',
        room_id: @room.id,
        category: '食費',
        date: '2020-04-12'
       } }
    end
  end

  test 'can update an item with login' do
    sign_in @user
    @item = items(:meal)
    assert patch item_url(@item), 
      params:{ item: {
        value: 700, 
        room_id: @room.id
        } }
    assert_redirected_to room_url(@room)
  end

  test 'cannot update an item without login' do
    @item = items(:meal)
    patch item_url(@item), 
      params:{ item: {
        value: 700
        } }
    assert_redirected_to new_user_session_url
  end

  test 'other user cannot update an item' do
    sign_in @other_user
    @item = items(:meal)
    patch item_url(@item), 
      params:{ item: {
        value: 700,
        room_id: @room.id
        } }
    assert_redirected_to @other_user
  end

  test 'other user cannot destroy an item' do
    sign_in @other_user
    @item = items(:meal)
    delete item_url(@item, room_id: @room.id)
    assert_redirected_to @other_user
  end
end
