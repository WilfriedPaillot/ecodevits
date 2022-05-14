class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string , null: false
    add_index :users, :username, unique: true
    add_column :users, :approved, :boolean, default: true
  end
end
