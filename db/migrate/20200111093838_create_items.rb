class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :catogory
      t.datetime :date
      t.integer :value
      t.text :memo

      t.timestamps
    end
  end
end
