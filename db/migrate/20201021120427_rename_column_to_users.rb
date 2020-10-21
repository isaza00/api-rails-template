class RenameColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_admin, :boolean, default: false
    rename_column :users, :password, :password_digest
  end
end
