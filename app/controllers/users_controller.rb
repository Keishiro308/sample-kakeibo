class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :info]
  before_action :correct_user, only: [:show, :info]
  def home
    if user_signed_in?
      @rooms = current_user.rooms
      @inviteds = Invite.where(invited_id: current_user.id)
    end
  end

  def show
    if user_signed_in?
      @rooms = current_user.rooms
      @inviteds = Invite.where(invited_id: current_user.id)
    end
  end

  def info
    @user = User.find(params[:id])
  end
  
end
