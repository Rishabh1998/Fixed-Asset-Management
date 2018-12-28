class Department < ApplicationRecord
  has_many :categories, dependent: :destroy
 enum status: [:not_active,:active]
end
