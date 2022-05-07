class TrainingUser < ApplicationRecord
  belongs_to :training
  belongs_to :user

  validates :training_id, :user_id, presence: true
  validates :training_id, uniqueness: { scope: :user_id, message: ' est déjà inscrit à ce cours' }
end