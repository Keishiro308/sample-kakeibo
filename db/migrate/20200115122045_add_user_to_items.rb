class AddUserToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :user_id, :integer, :null => false
    #Ex:- :null => false
  end
end
