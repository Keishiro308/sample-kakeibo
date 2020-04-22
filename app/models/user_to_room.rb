class UserToRoom < ApplicationRecord
  belongs_to :user, inverse_of: 'joins'
  belongs_to :room, inverse_of: 'paticipants'
end

