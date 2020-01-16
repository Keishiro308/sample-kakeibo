class ApplicationController < ActionController::Base
  before_action :set_host

  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end
  private
    def correct_user
      user = User.find(params[:id])
      unless current_user == user
        flash[:alert] = 'アクセス権限がありません'
        redirect_to current_user
      end
    end
    
end
