class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.integer :inviting_id
      t.integer :invited_id
      t.integer :room_id

      t.timestamps
    end
  end
end
