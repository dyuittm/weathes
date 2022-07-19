class Prefecture < ApplicationRecord

  has_one :customer

  validates :name, presence: true

  def self.search_for(content)
    if content != ""
      Prefecture.where('name LIKE ?', '%'+content+'%')
    else
      Post.all
    end
  end
end
