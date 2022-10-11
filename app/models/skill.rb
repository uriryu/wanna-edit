class Skill < ApplicationRecord
  has_many :skill_genres, dependent: :destroy
  has_many :genres, through: :skill_genres, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :body, presence: true
  validates :price, presence: true
end
