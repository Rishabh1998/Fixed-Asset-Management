class Department < ApplicationRecord
  has_many :categories, dependent: :destroy

end
