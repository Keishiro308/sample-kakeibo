class Item < ApplicationRecord
  belongs_to :room

  def start_time
    self.date
  end
  
end
