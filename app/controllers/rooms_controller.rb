class RoomsController < ApplicationController
  def create
    
  end
  def destroy
    
  end
  private
    def room_params
      params.require(:rooms).permit(:name)
    end
end
