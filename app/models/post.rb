class Post < ApplicationRecord

  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :post_image

  validates :title, length: {in: 1..50}
  validates :body, length: {in: 1..200}

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

end
