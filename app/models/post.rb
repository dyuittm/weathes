class Post < ApplicationRecord
  FILE_NUMBER_LIMIT = 4

  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many_attached :post_images

  validates :title, length: {in: 1..50}, presence:true
  validates :body, length: {in: 1..200}, presence:true
  validate :validate_number_of_files

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  def validate_number_of_files
    if post_images.length > FILE_NUMBER_LIMIT
      errors.add(:post_images, "に添付できる画像は4件までです。")
    elsif post_images.length == 0
      errors.add(:post_images, "画像が添付されていません。")
    end
  end

  def self.search_for(content)
    if content != ""
      Post.where('title LIKE ? OR body LIKE ?', '%'+content+'%', '%'+content+'%')
    else
      Post.all
    end
  end

end
