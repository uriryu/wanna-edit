class Genre < ApplicationRecord
  has_many :skill_genres, dependent: :destroy
  has_many :skills, through: :skill_genres
  validates :name, presence: true

  scope :only_active, -> { where(is_active: true) }

  validates :name, presence: true, uniqueness: true
end
