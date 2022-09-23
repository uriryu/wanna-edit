class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :works, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :telephone_number, presence: true, format: { with: /\A\d{10,11}\z/ }

  enum is_editor: { normal_user: 0, editor_user: 1 }

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  # Viewの方で引数を設定するとそのサイズにリサイズできる形になっている↑。
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "ゲスト"
      user.telephone_number = '00011112222'
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

end
