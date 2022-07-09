class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_one_attached :profile_image

  validates :last_name, length: {in: 2..25}, uniqueness: true
  validates :first_name, length: {in: 2..25}, uniqueness: true
  validates :last_name_kana, length: {in: 2..25}, uniqueness: true
  validates :first_name_kana, length: {in: 2..25}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  validates :user_name, length: {in: 2..10}

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

end
