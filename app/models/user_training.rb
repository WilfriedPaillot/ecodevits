class UserTraining < ApplicationRecord
  after_initialize :init_completed

  belongs_to :training
  belongs_to :user
  has_many :sections, through: :training
  has_many :lessons, through: :sections

  validates :training, :user, presence: true
  validates :training, uniqueness: { scope: :user, message: ' est déjà inscrit à ce cours' }
  # validates :completed , inclusion: { in: [true, false] }, on: :update


  def init_completed
    self.completed ||= false
  end

end
