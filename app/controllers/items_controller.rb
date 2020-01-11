class ItemsController < ApplicationController
  def index
    
  end
  
  def show
    
  end

  def new
    
  end

  def create
    
  end
  
  def destroy
    
  end

  private
    def items_params
      params.require(:item).permit(:room_id, :name, :category, :date, :value, :memo)
    end
end
