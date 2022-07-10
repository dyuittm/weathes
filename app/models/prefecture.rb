class Prefecture < ApplicationRecord

  has_one :customer

  validates :name, presence: true

end
