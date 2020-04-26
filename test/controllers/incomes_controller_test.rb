require 'test_helper'

class IncomesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:ken)
    @room = rooms(:room1)
    @other_user = users(:john)
    @income = incomes(:kyuuryou)
  end

  test 'can create an income with login' do
    sign_in @user
    assert_difference 'Income.count', 1 do
      post incomes_url, 
      params:{ income: {
        value: 500,
        user_id: @user.id,
        room_id: @room.id,
        date: '2020-04-12'
       } }
    end
  end

  test 'cannot create an income without login' do
    assert_no_difference 'Income.count' do
      post incomes_url, 
      params:{ income: {
        value: 500,
        user_id: @user.id,
        room_id: @room.id,
        date: '2020-04-12'
       } }
    end
  end

  test 'other user cannot create an income' do
    sign_in @other_user
    assert_no_difference 'Item.count' do
      post incomes_url, 
      params:{ income: {
        value: 500,
        user_id: @user.id,
        room_id: @room.id,
        date: '2020-04-12'
       } }
    end
    assert_redirected_to @other_user
  end

  test 'cannot create an income with invalid parameter' do
    sign_in @user
    assert_no_difference 'Income.count' do
      post incomes_url, 
      params:{ income: {
        value: 500,
        user_id: '',
        room_id: @room.id,
        date: '2020-04-12'
       } }
    end
  end

  test 'can update an income with login' do
    sign_in @user
    assert patch income_url(@income), 
      params:{ income: {
        value: 700, 
        room_id: @room.id
        } }
    assert_redirected_to room_url(@room)
  end

  test 'cannot update an income without login' do
    patch income_url(@income), 
      params:{ income: {
        value: 700
        } }
    assert_redirected_to new_user_session_url
  end

  test 'other user cannot update an income' do
    sign_in @other_user
    patch income_url(@income), 
      params:{ income: {
        value: 700,
        room_id: @room.id
        } }
    assert_redirected_to @other_user
  end

  test 'other user cannot destroy an income' do
    sign_in @other_user
    delete income_url(@income, room_id: @room.id)
    assert_redirected_to @other_user
  end
end
