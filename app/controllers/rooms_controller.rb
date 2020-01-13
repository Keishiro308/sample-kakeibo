class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_member, only: [:show_date, :show, :destory]
  def new
    @room = Room.new
  end

  def create
    if current_user.rooms << Room.new(room_params)
      flash[:success] = '新しい家計簿を作りました'
      redirect_to current_user
    else
      flash[:alert] = '家計簿を作れませんでした'
      render new
    end
  end
  def destroy
    room = current_user.rooms.find(params[:id])
    if room.destroy
      flash[:success] = '家計簿を削除しました'
      redirect_to current_user
    else
      flash[:alert] = '家計簿を削除できませんでした'
      redirect_to current_user
    end
  end
  

  def show
    @room = Room.find(params[:id])
    @date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    term = @date.beginning_of_month..@date.end_of_month
    term_year = @date.beginning_of_year..@date.end_of_year
    @items = @room.items.where(date: term)
    @month_total_cost = Item.where(date: term, room_id: params[:id]).sum(:value)
    @year_total_cost = {
      "1月":0,
      "2月":0,
      "3月":0,
      "4月":0,
      "5月":0,
      "6月":0,
      "7月":0,
      "8月":0,
      "9月":0,
      "10月":0,
      "11月":0,
      "12月":0
    }

    month_costs = Item.where(date: term_year, room_id: params[:id]).group_by{ |item| item.date.month }
    .map{
      |k, month_items| [
        "#{k}月", 
        month_items.map(&:value).inject{
         |sum, value| sum + value
        }
      ]
    }.to_h
    
    month_costs.each{|k,cost| @year_total_cost[:"#{k}"] = cost}

    @percentages = @items.group(:category).sum(:value).map{
      |k,v| [k, (v.to_f / @month_total_cost * 100).round]
    }.to_h
  end

  def show_date
    @room = Room.find(params[:id])
    @date = Date.parse(params[:date])
    @items = @room.items.where(date: params[:date])
    @total_values = @items.group(:category).sum(:value)
  end
  
  
  private
    def room_params
      params.require(:room).permit(:name)
    end

    def correct_member
      room = Room.find(params[:id])
      unless room.member?(current_user)
        flash[:alert] = 'その家計簿のメンバーではありません'
        redirect_to current_user
      end
    end
    
end
