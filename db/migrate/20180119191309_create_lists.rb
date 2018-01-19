class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :name
      t.text :description
      t.boolean :active, default: true
      t.integer :items_count, default: 0

      t.timestamps
    end
  end
end
