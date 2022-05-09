class CreateUserTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_trainings do |t|
      t.references :user, foreign_key: true
      t.references :training, foreign_key: true
      t.integer :completed, default: false
      t.text :lessons_completed, array: true, default: []

      t.timestamps
    end
  end
end
