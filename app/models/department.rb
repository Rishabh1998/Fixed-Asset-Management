class Department < ApplicationRecord
  has_many :categories, dependent: :destroy
 enum status: [:not_active,:active]
  def code
    last_code = Department.maximum(:department_code)
    self.department_code = last_code.to_i + 1
  end
end
