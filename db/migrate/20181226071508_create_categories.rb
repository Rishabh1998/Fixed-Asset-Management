class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.references :department, foreign_key: true
      t.string :name
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
