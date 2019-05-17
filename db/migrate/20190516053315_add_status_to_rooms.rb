class AddStatusToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :status, :boolean, default: true
  end
end
