class Item < ApplicationRecord
  belongs_to :room
  belongs_to :user
  with_options presence: true do
    validates :value
    validates :category
    validates :date
    validates :room_id
  end
  def start_time
    self.date
  end
  
end
