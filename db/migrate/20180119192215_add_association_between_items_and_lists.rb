class AddAssociationBetweenItemsAndLists < ActiveRecord::Migration[5.1]
  def change
    change_table :items do |t|
      t.references :list
    end
  end
end
