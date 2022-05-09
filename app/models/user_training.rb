class UserTraining < ApplicationRecord
  after_initialize :init_completion_rate

  belongs_to :training
  belongs_to :user

  validates :training, :user, presence: true
  validates :training, uniqueness: { scope: :user, message: ' est déjà inscrit à ce cours' }
  validates :completion_rate, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: ' doit être un nombre entier compris entre 0 et 100' }


  def init_completion_rate
    self.completion_rate ||= 0
  end
end
