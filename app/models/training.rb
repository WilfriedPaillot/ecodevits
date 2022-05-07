class Training < ApplicationRecord
  belongs_to :user
  has_many :sections, dependent: :destroy
  has_many :lessons, through: :sections
  has_many :trainings_users

  # Validates presence of minimum data for a training
  validates :title, :description, :user_id, presence: { message: "doit être renseigné" }
  # Validates title length and uniqueness for user (insctructor)
  validates :title, uniqueness: { scope: :user_id, message: ' est déjà utilisé pour l\'un de vos cours' }
  validates :title, length: { in: 10..50, message: ' doit contenir entre 10 et 50 caractères' }, on: :create
  # Validates description length
  validates :description, length: { minimum: 50, message: ' doit contenir au moins 50 caractères' }, on: :create
end