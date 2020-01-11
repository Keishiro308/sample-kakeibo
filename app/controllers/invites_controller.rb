class InvitesController < ApplicationController
  def create
    
  end
  def destroy
    
  end

  private
    def invite_params
      params.require(:invites).permit(:inviting_id, :invited_id, :room_id)
    end
end
