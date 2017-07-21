class ProductsTable < ActiveRecord::Migration[5.1]
  def change
  	drop_table :products

  	create_table :products do |t|
      t.string :name
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :price
      t.text :short_description
      t.text :full_description

      t.timestamps
    end
  end
end
