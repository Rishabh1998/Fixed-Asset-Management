class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :category, foreign_key: true
      t.references :department, foreign_key: true
      t.string :name
      t.string :description
      t.integer :status
      t.integer :item_code
      t.string :item_code_final
      t.string :current_location


      t.timestamps
    end
  end
end
