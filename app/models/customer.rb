class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :prefecture
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower


  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_one_attached :profile_image

  validates :last_name, length: {in: 1..25}, uniqueness: true
  validates :first_name, length: {in: 1..25}, uniqueness: true
  validates :last_name_kana, length: {in: 1..25}, uniqueness: true
  validates :first_name_kana, length: {in: 1..25}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end

  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end

  def following?(customer)
    followings.include?(customer)
  end
　#guestuser existing data or non-existent data
  def self.guest
    find_or_create_by!(prefecture_id: [1], email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.first_name = "guest"
      customer.last_name = "user"
      customer.first_name_kana = "ゲスト"
      customer.last_name_kana = "ユーザー"
      customer.user_name = "guestuser"
      customer.prefecture_id = 1
    end
  end

end
