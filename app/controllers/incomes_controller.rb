class IncomesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_member, only: [:edit, :update, :create, :destroy]
  
  def new
    @item = Item.new
    @income = Income.new
    @room = Room.find(params[:room_id])
    @the_day = params[:date].nil? ? Date.today : Date.parse(params[:date])
  end


  def create
    @income = Income.new(income_params)
    @room = Room.find(income_params[:room_id]) unless income_params[:room_id].nil?
    if @income.save
      flash[:notice] = '追加しました'
      redirect_to room_path(@income.room.id)
    else
      flash.now[:alert] = '追加できませんでした'
      render 'new'
    end
  end

  def edit
    @room = Room.find(params[:room_id])
    @income = @room.incomes.find(params[:id])
  end
  
  def update
    @income = Income.find(params[:id])
    if @income.update(income_params) || @income
      flash[:notice] = '更新できました'
      redirect_to room_path(@income.room)
    else
      flash.now[:alert] = '更新できませんでした'
      redirect_to root_path
    end
  end
  
  def destroy
    @income = Income.find(params[:id])
    date = @income.date
    room_id = @income.room_id
    if @income.destroy
      flash[:notice] = '削除しました'
    else
      flash.now[:alert] = '削除できませんでした'
    end
    redirect_to room_date_path(room_id, date)
  end

  private
    def income_params
      params.require(:income).permit(:room_id, :name, :date, :value, :memo, :user_id)
    end
    def correct_member
      room = params[:room_id] ? Room.find(params[:room_id]) : Room.find(income_params[:room_id])
      unless room.member?(current_user)
        flash[:alert] = 'その家計簿のメンバーではありません'
        redirect_to current_user
      end
    end
end
