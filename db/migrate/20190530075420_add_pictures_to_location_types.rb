class AddPicturesToLocationTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :location_types, :pictures, :json
  end
end
