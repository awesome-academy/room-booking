class ChangeColumnPriceInRooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :rooms, :price
    add_monetize :rooms, :price
  end
end
