class Invite < ApplicationRecord
  belongs_to :inviting_user, class_name: 'User', foreign_key: 'inviting_id', inverse_of: 'invites'
  belongs_to :invited_user, class_name: 'User', foreign_key: 'invited_id', inverse_of: 'inviteds'
  belongs_to :room

  

end
