class Item < ApplicationRecord
  belongs_to :category
  belongs_to :department
  has_many :location_detail, dependent: :destroy
  enum status: [:not_active,:active]
  def code
    last_code = Item.maximum(:item_code)
    self.item_code = last_code.to_i + 1
  end
  def generate_code
    #we selected the department_code from department table , by finding it through department_id of department table
    department = Department.find_by(:id => self.department_id).department_code

    category = Category.find_by(:id => self.category_id).category_code
    #we selected item_code from item table (we use self.column nmae to extract value from database)
    item = self.item_code

    if department < 10
      #converting value in variable department using .to_s
      sh_department = '0'+department.to_s
    else
      sh_department = department.to_s
    end
    if category < 10
      s_category = '0'+category.to_s
    else
      s_category = category.to_s
    end

    if item < 10
      s_item = '000' +item.to_s
    elsif self.id <100
      s_item = '0' +item.to_s

    else
      s_item = item.to_s
    end

    code = sh_department + s_category + s_item

#storing the value of code in database
    self.item_code_final=code
  end


  #def location

   # current_location = self.current_location
    #previous_location = find_by(:id => self.id).current_location
    #if current_location .changed?
     # render json: {status: 'SUCCESS' }
      #location=  LocationDetail.new(:item_id => self.id ,:location_history => self.current_location )

    #end
  #end
 #def location

# if current_location == previous_location
#   continue
# else

  #location=  LocationDetail.new(:item_id => self.id ,:location_history => self.current_location )
   #if location.save
    # render json: {status: 'SUCCESS', message: 'department created', data: location},status: :ok
   #else
    # render json: {status: 'SUCCESS', message: 'department created', data: location.errors},status: :ok


 #end
  #end
  #end

  end