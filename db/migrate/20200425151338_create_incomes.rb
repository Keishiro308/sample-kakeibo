class CreateIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :incomes do |t|
      t.string :name
      t.date :date, null: false
      t.integer :value, null: false
      t.text :memo
      t.references :user
      t.references :room
      t.timestamps
    end
  end
end
