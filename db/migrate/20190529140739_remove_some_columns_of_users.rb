class RemoveSomeColumnsOfUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :email
    remove_column :users, :password_digest
    remove_column :users, :remember_digest
    remove_column :users, :activation_digest
    remove_column :users, :activated
    remove_column :users, :activated_at
    remove_column :users, :reset_digest
    remove_column :users, :reset_sent_at
  end
end
