class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_member, only: [:show_date, :show, :destroy]
  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      flash[:notice] = '新しい家計簿を作りました'
      redirect_to current_user
    else
      flash.now[:alert] = '家計簿を作れませんでした'
      render 'new'
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if (@room.update(room_params) || @room) && room_params[:name].present?
      flash[:notice] = '名前を変更しました'
      redirect_to current_user
    else
      flash[:alert] = '名前を変更できませんでした'
      render 'edit'
    end
  end
  
  

  def destroy
    room = Room.find(params[:id])
    invites = Invite.where(room_id: room.id)
    if room.destroy
      invites.each do |invite|
        invite.destroy
      end
      flash[:notice] = '家計簿を削除しました'
      redirect_to root_path
    else
      flash[:alert] = '家計簿を削除できませんでした'
      redirect_to root_path
    end
  end
  

  def show
    @room = Room.includes(:users).find(params[:id])
    @date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    term = @date.beginning_of_month..@date.end_of_month
    term_year = @date.beginning_of_year..@date.end_of_year
    @items = @room.items.where(date: term)
    @total_values = @items.group(:category).sum(:value)
    @month_total_cost = @items.sum(:value)
    @by_month_costs = Item.caliculate_month_costs(term_year, params)
    @percentages = Item.caliculate_percentage(@room, term)
    @percentages_year = Item.caliculate_percentage(@room, term_year)
  end

  def show_date
    @room = Room.find(params[:id])
    @date = Date.parse(params[:date])
    @items = @room.items.where(date: params[:date])
    @total_values = @items.group(:category).sum(:value)
  end

  def exit
    join = current_user.joins.find_by(room_id: params[:id])
    room = current_user.rooms.find(params[:id])
    if room.users.size == 1
      room.destroy
    end
    join.destroy
    flash[:notice] = "#{room.name}を退出しました"
    redirect_to root_path
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
