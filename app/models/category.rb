class Category < ApplicationRecord
  belongs_to :department
  enum status: [:not_active,:active]
end
