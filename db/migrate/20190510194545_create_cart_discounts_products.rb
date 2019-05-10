class CreateCartDiscountsProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_discounts_products do |t|
      t.belongs_to :cart_discount, foreign_key: true
      t.belongs_to :product, foreign_key: true

      t.timestamps
    end
  end
end
