class Work < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :reviews

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

end
