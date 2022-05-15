class AddUrlcolumnToLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :url, :string
  end
end
