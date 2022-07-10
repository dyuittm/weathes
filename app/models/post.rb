class Post < ApplicationRecord

  belongs_to :customer
  has_many :post_comments, dependent: :destroy

  has_one_attached :post_image

  validates :title, length: {in: 1..50}
  validates :body, length: {in: 1..200}

end
