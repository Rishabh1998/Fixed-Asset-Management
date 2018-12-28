class Item < ApplicationRecord
  belongs_to :category
  belongs_to :department
  enum status: [:not_active,:active]
end
