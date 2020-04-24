require 'test_helper'

class InvitesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:ken)
    @room_member = users(:tanaka)
    @already_invited_user = users(:maeda)
    @other_user = users(:john)
    @room = rooms(:room1)
  end

  test 'cannot invite me' do
    sign_in @user
    assert_no_difference "Invite.count" do
      post invites_path, 
        params: { invite: {
          room_id: @room.id,
          unique_id: @user.unique_id,
          inviting_id: @user.id
        } }
    end
    assert_redirected_to new_room_invite_url(room_id: @room.id)
  end

  test 'cannot invite who already joined the room' do
    sign_in @user
    assert_no_difference "Invite.count" do
      post invites_path, 
        params: { invite: {
          room_id: @room.id,
          unique_id: @room_member.unique_id,
          inviting_id: @user.id
        } }
    end
    assert_redirected_to new_room_invite_url(room_id: @room.id)
  end

  test 'cannot invite who already been invited to the room' do
    sign_in @user
    assert_no_difference "Invite.count" do
      post invites_path, 
        params: { invite: {
          room_id: @room.id,
          unique_id: @already_invited_user.unique_id,
          inviting_id: @user.id
        } }
    end
    assert_redirected_to new_room_invite_url(room_id: @room.id)
  end

  test 'other user cannot invite' do
    sign_in @other_user
    assert_no_difference "Invite.count" do
      post invites_path, 
        params: { invite: {
          room_id: @room.id,
          unique_id: @other_user.unique_id,
          inviting_id: @user.id
        } }
    end
    assert_redirected_to @other_user
  end

  test 'cannot create invite without unique_id' do
    sign_in @user
    assert_no_difference "Invite.count" do
      post invites_path, 
        params: { invite: {
          room_id: @room.id,
          inviting_id: @user.id
        } }
    end
    assert_redirected_to new_room_invite_path(@room)
  end

  test 'cannot create invite without inviting_id' do
    sign_in @user
    assert_no_difference "Invite.count" do
      post invites_path, 
        params: { invite: {
          room_id: @room.id,
          unique_id: @other_user.unique_id
        } }
    end
    assert_redirected_to new_room_invite_path(@room)
  end

  test 'other user cannot destroy invite' do
    @invite = invites(:one)
    sign_in @other_user
    assert_no_difference "Invite.count" do
      delete invite_path(@invite, room_id: @room.id)
    end
    assert_redirected_to @other_user
  end

  test 'other user cannot join the room' do
    @invite = invites(:one)
    sign_in @other_user
    assert_no_difference "UserToRoom.count" do
      post rooms_add_invite_path(@invite)
    end
    assert_redirected_to @other_user
  end

  test 'can invite other user' do
    sign_in @user
    assert_difference "Invite.count", 1 do
      post invites_path,
        params: { invite: {
          room_id: @room.id,
          unique_id: @other_user.unique_id,
          inviting_id: @user.id
        }}
    end
    assert_redirected_to @user
  end

  test 'can destroy invite' do
    @invite = invites(:one)
    sign_in @user
    assert_difference "Invite.count", -1 do
      delete invite_path(@invite, room_id: @room.id)
    end
    assert_redirected_to @user
  end

  test 'already invited user can join the room' do
    @invite = invites(:one)
    sign_in @already_invited_user
    assert_difference "UserToRoom.count", 1 do
      post rooms_add_invite_path(@invite)
    end
    assert_redirected_to @already_invited_user
  end
end
