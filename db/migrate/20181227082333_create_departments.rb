class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :description
      t.integer :status
      t.integer :department_code


      t.timestamps
    end
  end
end
