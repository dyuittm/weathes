class Relationship < ApplicationRecord

  belongs_to :follwer, class_name: "Customer"
  belongs_to :follwed, class_name: "Customer"

end
