class AddColumnToTrainingsUser < ActiveRecord::Migration[5.2]
  def change
    add_column :trainings_users, :completion_rate, :integer
  end
end
