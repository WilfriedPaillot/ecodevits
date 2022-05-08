class Lesson < ApplicationRecord
  belongs_to :section
  
  # Validates presence of minimum data for a lesson
  validates :title, :content, :section_id, presence: { message: "doit être renseigné" }
  # Validates title length and uniqueness within a section
  validates :title, uniqueness: { scope: :section_id, message: ' est déjà utilisé pour une leçon de cette section' }
  validates :title, length: { in: 10..100, message: ' doit contenir entre 10 et 100 caractères' }, on: :create
  
  # Validates content length
  validates :content, length: { minimum: 150, message: ' doit contenir au moins 150 caractères' }, on: :create


  # Returns the next lesson in the section
  def next
    section.lessons.find_by(id: self.id + 1) if self.id != section.lessons.last.id
  end
  # Returns the first lesson of the next section
  def first_of_next_section
    section.training.sections.find_by(id: self.section.id + 1).lessons.first if self.section.id != section.training.sections.last.id
  end
  # Returns true if the lesson isnt the last one in the section
  def isnt_last_lesson?
    self.id != section.lessons.last.id
  end
  # Returns true if the lesson's training count more than one section AND the section isnt the last one
  def next_section?
    self.section.training.sections.count > 1 && self.section.id != section.training.sections.last.id
  end

end