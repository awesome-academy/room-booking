class ChangeDataTypeForComment < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :comment, :text
  end
end
