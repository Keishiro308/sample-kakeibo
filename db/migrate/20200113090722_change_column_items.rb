class ChangeColumnItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :date, :date, null: false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
