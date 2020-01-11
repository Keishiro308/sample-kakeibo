class RemoveCatogoryFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :catogory, :string
    add_column :items, :category, :string
  end
end
