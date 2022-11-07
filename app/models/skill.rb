class Skill < ApplicationRecord
  belongs_to :user
  has_many :skill_genres, dependent: :destroy
  has_many :genres, through: :skill_genres, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :order_details
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :body, presence: true
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }

  scope :where_genre_active, -> { joins(:genre).where(genres: { is_active: true }) }

  def get_image(*size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'no_image.png', content_type: 'image/png')
    end

    if !size.empty?
      image.variant(resize: size)
    else
      image
    end
  end

  def with_tax_price
    (price * 1.1).floor
    # ceilは切り上げ、floorが切り捨て、roundが四捨五入
  end

  def image_type
    if !image.blob
      errors.add(:image, 'をアップロードしてください')
    elsif !image.blob.content_type.in?(%('image/jpeg image/png'))
      errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
    end
  end

  def self.recommended
    recommends = []
    active_genres = Genre.only_active.includes(:skills)
    active_genres.each do |genre|
      skill = genre.skills.first
      recommends << skill if skill
    end
    recommends
  end
end
