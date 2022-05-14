class AddSpecColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :specialities, :text, array: true, default: []
  end
end
