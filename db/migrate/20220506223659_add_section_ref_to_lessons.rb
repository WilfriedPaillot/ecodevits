class AddSectionRefToLessons < ActiveRecord::Migration[5.2]
  def change
    add_reference :lessons, :section, foreign_key: true
  end
end
