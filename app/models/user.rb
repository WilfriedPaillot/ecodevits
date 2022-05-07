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
  has_many :trainings_users, dependent: :destroy
  has_many :trainings, through: :trainings_users
  has_many :sections, through: :trainings
  has_many :lessons, through: :sections

  private
    def set_default_role
      self.role ||= :student
    end
end
  
  # # Associations for instructor
  # has_many :trainings, dependent: :destroy
  # has_many :sections, through: :trainings
  # has_many :lessons, through: :sections
  # # Associations for student
  # has_many :trainings_users, dependent: :destroy
  # has_many :following_trainings, through: :trainings_users, source: :training