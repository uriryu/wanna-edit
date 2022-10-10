class Work < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  has_one_attached :image

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

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def avg_score
    unless self.reviews.empty?
      reviews.average(:reputation).round(1).to_f
    else
      0.0
    end
  end

end
