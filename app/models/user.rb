class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :joins, class_name: "UserToRoom",
                    foreign_key: 'user_id',
                    dependent: :destroy
  has_many :rooms, through: :joins
  has_many :invites, class_name: 'Invite', foreign_key: 'inviting_id'
  has_many :inviteds, class_name: 'Invite', foreign_key: 'invited_id'
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
