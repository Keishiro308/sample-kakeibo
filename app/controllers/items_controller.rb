class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_member, only: [:new, :edit]
  
  def new
    @options = [
      ['ーー選択してくださいーー', ''],
      ['食費', '食費'],
      ['日用品', '日用品'],
      ['交通費', '交通費'],
      ['趣味', '趣味'],
      ['衣服', '衣服'],
      ['美容', '美容'],
      ['交際費', '交際費'],
      ['教養・教育', '教養・教育'],
      ['健康・医療', '健康・医療'],
      ['金融', '金融'],
      ['住宅', '住宅'],
      ['水道光熱費', '水道光熱費'],
      ['通信費', '通信費'],
      ['税金', '税金'],
      ['自動車', '自動車'],
      ['その他', 'その他']
    ]
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    if item.save
      flash.now[:notice] = '追加しました'
      redirect_to room_path(item.room.id)
    else
    
    end
  end

  def edit
    @options = [
      ['ーー選択してくださいーー', ''],
      ['食費', '食費'],
      ['日用品', '日用品'],
      ['交通費', '交通費'],
      ['趣味', '趣味'],
      ['衣服', '衣服'],
      ['美容', '美容'],
      ['交際費', '交際費'],
      ['教養・教育', '教養・教育'],
      ['健康・医療', '健康・医療'],
      ['金融', '金融'],
      ['住宅', '住宅'],
      ['水道光熱費', '水道光熱費'],
      ['通信費', '通信費'],
      ['税金', '税金'],
      ['自動車', '自動車'],
      ['その他', 'その他']
    ]
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params) || @item
      flash[:notice] = '更新できました'
      redirect_to room_path(@item.room)
    else
      flash[:alert] = '更新できませんでした'
      redirect_to root_path
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    date = @item.date
    room = @item.room_id
    if @item.destroy
      flash[:notice] = '削除しました'
    else
      flash[:alert] = '削除できませんでした'
    end
    redirect_to room_date_path(room, date)
  end

  private
    def item_params
      params.require(:item).permit(:room_id, :name, :category, :date, :value, :memo)
    end
    def correct_member
      room = Room.find(params[:room_id])
      unless room.member?(current_user)
        flash[:alert] = 'その家計簿のメンバーではありません'
        redirect_to current_user
      end
    end
end
