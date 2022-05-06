class Section < ApplicationRecord
  belongs_to :training
  has_many :lessons, dependent: :destroy
end