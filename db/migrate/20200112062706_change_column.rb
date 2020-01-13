class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    change_column_null :items, :value, true
    change_column_null :items, :date, true
    change_column_null :items, :room_id, true
    change_column_null :items, :category, true
    change_column_null :invites, :invited_id, true
    change_column_null :invites, :room_id, true
    change_column_null :invites, :inviting_id, true
    change_column_null :user_to_rooms, :user_id, true
    change_column_null :items, :room_id, true
    change_column_null :users, :unique_id, true
    change_column_null :rooms, :name, true
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
