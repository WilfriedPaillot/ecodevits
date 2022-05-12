class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  enum role: [:student, :instructor, :admin]
  after_initialize :set_default_role, :if => :new_record?

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

  private
    def set_default_role
      self.role ||= :student
    end
  end

