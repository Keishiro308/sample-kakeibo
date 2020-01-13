class ApplicationController < ActionController::Base
  private
    def correct_user
      user = User.find(params[:id])
      unless current_user == user
        flash[:alert] = 'アクセス権限がありません'
        redirect_to current_user
      end
    end
    
end
