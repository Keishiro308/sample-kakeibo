require 'test_helper'

class InviteFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:ken)
    @invited_user = users(:maeda)
    @other_user = users(:john)
    @room = rooms(:room1)
    @invite = invites(:one)
    sign_in @user
  end

  test 'create invite' do
    get new_room_invite_url(@room)
    assert_response :success
    post invites_url,
      params: {
        invite: {
          unique_id: @other_user.unique_id,
          inviting_id: @user.id,
          room_id: @room.id
        }
      }
    assert_response :redirect
    follow_redirect!
    assert_equal "#{@other_user.name}さんを招待しました", flash[:notice]
    assert_select 'div.content', "#{@other_user.name}さんを#{@room.name}に招待しました"
  end
  
  test 'destroy invite' do
    get root_url
    assert_response :success
    assert_select 'div.content', "#{@invited_user.name}さんを#{@room.name}に招待しました"
    assert_select 'a.btn_delete_invite', '招待を取り消す'
    delete invite_url(@invite, room_id: @room.id)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal '招待を削除しました', flash[:notice]
  end
end
