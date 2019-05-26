class ChangeDataTypeForDescription < ActiveRecord::Migration[5.2]
  def change
    change_column :locations, :description, :text
  end
end
