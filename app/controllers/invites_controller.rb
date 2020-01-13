class InvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_member, only: [:new, :show]
  def new
    @invite = Invite.new
  end
  
  def create
    invited_user = User.find_by(unique_id: invite_params[:unique_id])
    room = Room.find(invite_params[:room_id])
    if invited_user.nil? || invited_user.id == current_user.id
      flash[:alert] = invited_user.nil? ? 'ユーザーが存在しません、IDを確認してください' : '自分を招待することはできません'
      redirect_to new_invite_path(room)
    else
      duplicated_invite = Invite.where(invited_id: invited_user.id, room_id: invite_params[:room_id])
      if duplicated_invite.present? || room.member?(invited_user)
        flash[:alert] = room.member?(invited_user) ? 'そのユーザーはすでに参加しています' : 'そのユーザーはすでに招待されています'
        redirect_to new_invite_path(room)
      else
        @invite = Invite.new(
          inviting_id: invite_params[:inviting_id],
          invited_id: invited_user.id,
          room_id: invite_params[:room_id]
        )
        if @invite.save
          flash[:notice] = "#{invited_user.name}さんを招待しました"
          redirect_to current_user
        else
          flash[:alert] = '招待できませんでした'
          render new
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
    if room.users << current_user
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
      room = Room.find(params[:id])
      unless room.member?(current_user)
        flash[:alert] = 'その家計簿のメンバーではありません'
        redirect_to current_user
      end
    end
    
end
