class Section < ApplicationRecord
  belongs_to :training
  has_many :lessons, dependent: :destroy

  #Validates presence of minimum data for a section
  validates :title, :description, :training_id, presence: { message: "doit être renseigné" }

  #Validates title length and uniqueness within a training
  validates :title, uniqueness: { scope: :training_id, message: ' est déjà utilisé pour une section de ce cours' }
  validates :title, length: { in: 10..50, message: ' doit contenir entre 10 et 50 caractères' }, on: :create

  #Validates description length
  validates :description, length: { minimum: 50, message: ' doit contenir au moins 50 caractères' }, on: :create
end