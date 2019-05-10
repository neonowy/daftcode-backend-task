class CreateCartDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_discounts do |t|
      t.integer :kind
      t.string :name
      t.float :price
      t.integer :count

      t.timestamps
    end
  end
end
