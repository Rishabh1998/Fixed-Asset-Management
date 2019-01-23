class Item < ApplicationRecord
  belongs_to :category
  belongs_to :department
  has_many :location_detail, dependent: :destroy
  enum status: [:Disabled,:Active]

  def code
    last_code = Item.maximum(:item_code)
    self.item_code = last_code.to_i + 1
  end

  def generate_code
    department = Department.find_by(:id => self.department_id).department_code
    category = Category.find_by(:id => self.category_id).category_code
    item = self.item_code
    if department < 10
      s_department = '0'+department.to_s
    else
      s_department = department.to_s
    end
    if category < 10
      s_category = '0'+category.to_s
    else
      s_category = category.to_s
    end

    if item < 10
      s_item = '000' +item.to_s
    elsif self.id <100
      s_item = '00' +item.to_s
    elsif self.id <1000
      s_item = '0' +item.to_s

    else
      s_item = item.to_s
    end

    code = s_department + s_category + s_item

    self.item_code_final=code
  end
end

