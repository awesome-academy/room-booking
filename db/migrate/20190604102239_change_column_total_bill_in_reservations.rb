class ChangeColumnTotalBillInReservations < ActiveRecord::Migration[5.2]
  def change
    remove_column :reservations, :total_bill
    add_monetize :reservations, :total_bill
  end
end
