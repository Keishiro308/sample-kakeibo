class Item < ApplicationRecord
  belongs_to :room
  belongs_to :user
  with_options presence: true do
    validates :value
    validates :category
    validates :date
    validates :room_id
  end
  validates :value, numericality: { only_integer: true }
  def start_time
    self.date
  end

  def self.caliculate_month_costs(term_year, params)
    by_month = where(date: term_year, room_id: params[:id]).group_by{ |item| item.date.month }
    year_total_cost = {
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
    month_costs = by_month.map{
      |k, month_items| [
        "#{k}月", 
        month_items.map(&:value).inject{
         |sum, value| sum + value
        }
      ]
    }.to_h
    
    month_costs.each{|k,cost| year_total_cost[:"#{k}"] = cost}
    year_total_cost
  end

  def self.caliculate_percentage(room, term)
    items = room.items.where(date: term)
    total_cost = items.sum(:value)
    hash = items.group(:category).sum(:value).map{
      |k, v| [k, (v.to_f / total_cost * 100).round]
    }.to_h
    hash
  end
  
end
