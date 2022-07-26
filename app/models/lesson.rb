class Lesson < ApplicationRecord
  belongs_to :section
  has_one_attached :video
  has_one_attached :thumbnail
  has_many_attached :documents

  # Validates presence of minimum data for a lesson
  validates :title, :content, :section_id, presence: { message: "doit être renseigné" }
  # Validates title length and uniqueness within a section
  validates :title, uniqueness: { scope: :section_id, message: ' est déjà utilisé pour une leçon de cette section' }
  validates :title, length: { in: 10..100, message: ' doit contenir entre 10 et 100 caractères' }, on: :create
  
  # Validates content length
  validates :content, length: { minimum: 150, message: ' doit contenir au moins 150 caractères' }, on: :create

  # Validates presence of video OR url
  validates :video, attached: { message: 'doit être uploadée si aucune URL saisie' }, if: :video_and_url_empty?
  validates :video, size: { less_than: 650.megabytes, message: ' est trop volumineux, préférez l\'URL s\'il vous plait' }
  validates :url, presence: {message: 'ne peut être vide si aucune vidéo uploadée'} , if: :video_and_url_empty?
  
  # Validates documents format, size and presence in non-empty lesson
  validates :documents, content_type: { in: %w[application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.ms-powerpoint application/vnd.openxmlformats-officedocument.presentationml.presentation], message: 'aux extensions acceptées: .pdf, .doc, .docx, .xls, .xlsx, .ppt, .pptx' }
  validates :documents, size: { less_than: 5.megabytes, message: ' est trop volumineux' }

  # Validates thumbnail content type and size
  validates :thumbnail, content_type: { in: %w[image/jpeg image/png image/svg], message: ' aux extensions .jpg, .jpeg, .png et .svg acceptées' }
  validates :thumbnail, size: { less_than: 5.megabytes, message: ' est trop volumineuse' }

  # Method for validation 
  def video_and_url_empty?
    video.attached? == false && url.blank?
  end
  # Returns the next lesson in the section
  def next
    # section.lessons.find(section.lessons.ids[section.lessons.ids.index(self.id) + 1]) if self.id != section.lessons.last.id #OK 
    section.lessons.find_by(id: self.id + 1) if self.id != section.lessons.last.id

    # # # all_lessons = section.lessons.ids
    # trier les lessons par leur id
    # # # all_lessons_sorted = all_lessons.sort_by! { |x| x.to_i }
    # trouver l'index de la lesson courante
    # # # index = all_lessons_sorted.index(self.id)
    # trouver l'id de la lesson suivante
    # # # section.lessons.find(all_lessons_sorted[index + 1])
    
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

  def next_section
    section.training.sections.find_by(id: self.section.id + 1) if self.section.id != section.training.sections.last.id
  end

end