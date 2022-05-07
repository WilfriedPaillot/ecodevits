class Lesson < ApplicationRecord
  belongs_to :section
  
  # Validates presence of minimum data for a lesson
  validates :title, :content, :section_id, presence: { message: "doit être renseigné" }
  # Validates title length and uniqueness within a section
  validates :title, uniqueness: { scope: :section_id, message: ' est déjà utilisé pour une leçon de cette section' }
  validates :title, length: { in: 10..100, message: ' doit contenir entre 10 et 100 caractères' }, on: :create
  
  # Validates content length
  validates :content, length: { minimum: 150, message: ' doit contenir au moins 150 caractères' }, on: :create

end