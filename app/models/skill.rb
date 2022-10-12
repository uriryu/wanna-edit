class Skill < ApplicationRecord
  has_many :skill_genres, dependent: :destroy
  has_many :genres, through: :skill_genres, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :body, presence: true
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  
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
    (price * 1.1).ceil
    # ceilは切り上げ、floorが切り捨て、roundが四捨五入
  end
  
  def image_type
    if !image.blob
      errors.add(:image, 'をアップロードしてください')
    elsif !image.blob.content_type.in?(%('image/jpeg image/png'))
      errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
    end
  end
end
