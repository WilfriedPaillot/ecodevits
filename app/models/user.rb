class User < ApplicationRecord
  after_initialize :set_approved_for_instructor, :if => :new_record?
  after_initialize :set_default_role, :if => :new_record?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  enum role: [:student, :instructor, :admin]

  #? Must changes for classname
    #? has_many :followed_trainings , through: :user_trainings, source: :training
    #? has_many :followed_sections , through: :user_trainings, source: :section
    #? has_many :followed_lessons , through: :user_trainings, source: :lesson

    #? has_many :authored_trainings, class_name: "Training", foreign_key: "author_id"
    #? has_many :authored_sections, class_name: "Section", foreign_key: "author_id"
    #? has_many :authored_lessons, class_name: "Lesson", foreign_key: "author_id"

  # Associations for instructor
  has_many :trainings, dependent: :destroy
  has_many :sections, through: :trainings
  has_many :lessons, through: :sections
  # Associations for student
  has_many :user_trainings, dependent: :destroy
  has_many :trainings, through: :user_trainings
  has_many :sections, through: :trainings
  has_many :lessons, through: :sections

  validates :username, presence: true, uniqueness: true
  validates :username, 
    length: { in: 3..15, message: ' doit contenir entre 3 et 15 caractères' },
    format: { with: /\A[a-zA-Z0-9_]+\z/, message: ' doit contenir uniquement des lettres, des chiffres et des underscores' },
    uniqueness: { case_sensitive: false }, on: :create
    validates :first_name, :last_name, allow_blank: true, 
    length: { minimum: 2, maximum: 20, message: "doit être compris entre 2 et 20 caractères" }, 
    format: { with: /\A[a-zA-Z\s\-\']+\z/ , message: "ne doit contenir que des lettres" },
    on: :update
  validates :adress, allow_blank: true, 
    length: { maximum: 100, message: "doit être inférieur à 100 caractères" }, 
    on: :update
  validates :zipcode, allow_blank: true, 
    length: { is: 5, message: "doit être de 5 caractères"}, 
    format: { with: /\A(([0-8][1-9])|(9[0-5]))[0-9]{3}|((97[1-8])[0-9]{2})|((98[1-8])[0-9]{2})|99138\z/ , message: "inexistant" }, 
    on: :update
  validates :city, allow_blank: true, 
    length: { maximum: 25, message: "doit être inférieur à 25 caractères" }, 
    format: { with: /\A[a-zA-Z\-\'\s]+\z/ , message: "ne doit contenir que des lettres" }, 
    on: :update

  def active_for_authentication? 
    super && approved?
  end 
  
  def inactive_message 
    approved? ? super : :not_approved
  end

  def is_authorized(training)
    self.role == "instructor" && training.user_id == self.id || self.role == "admin"
  end

  # def excluding_admins
  #   where.not(role: "admin")
  # end

  # def only_instructors
  #   where(role: "instructor")
  # end

  # def ordered_by_role_and_last_name
  #   order(:role, :last_name)
  # end

  private
    def set_default_role
      self.role ||= :student
    end

    def set_approved_for_instructor
      self.approved = false if self.role == "instructor"
    end
  end

