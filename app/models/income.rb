class Income < ApplicationRecord
  belongs_to :user
  belongs_to :room
  with_options presence: true do
    validates :value
    validates :date
    validates :room_id
    validates :user_id
  end
  validates :value, numericality: { only_integer: true }


  def start_time
    self.date
  end
end
