class CreateLocationDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :location_details do |t|
        t.references :item, foreign_key: true
        t.string :location_history
        t.timestamps
    end
  end
end
