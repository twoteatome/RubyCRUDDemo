class AlterOrderTable < ActiveRecord::Migration[5.1]
  def change
  	drop_table :orders

  	create_table :orders do |t|
      t.belongs_to :product, index: true
      t.belongs_to :user, index: true
      t.integer :quantity
      t.integer :status

      t.timestamps
    end
  end
end
