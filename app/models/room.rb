class Room < ApplicationRecord
  has_many :paticipants, class_name: 'UserToRoom',
                         foreign_key: 'room_id',
                         dependent: :destroy,
                         inverse_of: 'room'
  has_many :users, through: :paticipants
  accepts_nested_attributes_for :paticipants
  has_many :items, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :invites
  validates :name, presence: true

  def member?(user)
    users.include?(user)
  end

  
end
