class InvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_member, only: [:new, :create, :destroy]
  def new
    @invite = Invite.new
    @room = Room.find(params[:room_id])
  end
  
  def create
    room = Room.find(invite_params[:room_id])
    invited_user = User.find_by(unique_id: invite_params[:unique_id])
    if invited_user.nil? || invited_user.id == current_user.id
      flash[:alert] = invited_user.nil? ? 'ユーザーが存在しません、IDを確認してください' : '自分を招待することはできません'
      redirect_to new_room_invite_path(room)
    else
      duplicated_invite = room.invites.find_by(invited_id: invited_user.id)
      if duplicated_invite.present? || room.member?(invited_user)
        flash[:alert] = room.member?(invited_user) ? 'そのユーザーはすでに参加しています' : 'そのユーザーはすでに招待されています'
        redirect_to new_room_invite_path(room)
      else
        @invite = room.invites.build(
          inviting_id: invite_params[:inviting_id],
          invited_id: invited_user.id
        )
        if @invite.save
          flash[:notice] = "#{invited_user.name}さんを招待しました"
          redirect_to current_user
        else
          flash.now[:alert] = '招待できませんでした'
          redirect_to new_room_invite_path(room)
        end
      end
    end
  end

  def destroy
    invite = Invite.find(params[:id])
    if invite.destroy
      flash[:notice] = '招待を削除しました'
    else
      flash[:alert] = '招待を削除できませんでした'
    end
    redirect_to current_user
  end

  def add
    invite = Invite.find(params[:id])
    room = invite.room
    if invite.invited_user == current_user && room.users << current_user
      flash[:notice] = '参加しました'
      invite.destroy
    else
      flash[:alert] = '参加できませんでした'
    end
    redirect_to current_user
  end
  

  private
    def invite_params
      params.require(:invite).permit(:inviting_id, :unique_id, :room_id)
    end
    def correct_member
      room = params[:room_id] ? Room.find(params[:room_id]) : Room.find(invite_params[:room_id])
      unless room.member?(current_user)
        flash[:alert] = 'その家計簿のメンバーではありません'
        redirect_to current_user
      end
    end
    
end
