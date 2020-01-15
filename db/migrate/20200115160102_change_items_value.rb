class ChangeItemsValue < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :value, :integer, :null => false
    change_column :items, :category, :string, :null => false
    change_column :items, :room_id, :integer, :null => false
    #Ex:- :null => false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
