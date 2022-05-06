class CreateJoinTableUserTraining < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :trainings do |t|
      t.index [:user_id, :training_id]
      t.index [:training_id, :user_id]
    end
  end
end
