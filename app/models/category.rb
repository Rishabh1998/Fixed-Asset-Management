class Category < ApplicationRecord
  belongs_to :department
  enum status: [:not_active,:active]
  def code
    last_code = Category.maximum(:category_code)
    self.category_code = last_code.to_i + 1
  end
end
