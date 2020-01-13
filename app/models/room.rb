class Room < ApplicationRecord
  has_many :paticipants, class_name: 'UserToRoom',
                          foreign_key: 'room_id',
                          dependent: :destroy
  has_many :users, through: :paticipants
  has_many :items, dependent: :destroy
  has_many :invites

  def member?(user)
    users.include?(user)
  end
  
end
