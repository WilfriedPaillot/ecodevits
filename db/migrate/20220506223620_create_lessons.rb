class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :title , null: false
      t.text :content , null: false
    end
  end
end
