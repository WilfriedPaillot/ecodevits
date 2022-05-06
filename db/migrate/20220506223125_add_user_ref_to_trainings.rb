class AddUserRefToTrainings < ActiveRecord::Migration[5.2]
  def change
    add_reference :trainings, :user, foreign_key: true
  end
end
