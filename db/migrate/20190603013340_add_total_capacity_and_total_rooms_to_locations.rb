class AddTotalCapacityAndTotalRoomsToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :total_capacity, :integer, index: true
    add_column :locations, :total_rooms, :integer, index: true
  end
end
