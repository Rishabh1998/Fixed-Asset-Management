class Category < ApplicationRecord
  belongs_to :department
  enum status: [:Disabled,:Active]
  def code
    last_code = Category.maximum(:category_code)
    self.category_code = last_code.to_i + 1
  end
end
