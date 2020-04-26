class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :joins, class_name: "UserToRoom",
                    foreign_key: 'user_id',
                    dependent: :destroy,
                    inverse_of: 'user'
  has_many :rooms, through: :joins
  has_many :items
  has_many :incomes
  has_many :invites, class_name: 'Invite', inverse_of: 'inviting_user', foreign_key: 'inviting_id'
  has_many :inviteds, class_name: 'Invite', inverse_of: 'invited_user', foreign_key: 'invited_id'
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
