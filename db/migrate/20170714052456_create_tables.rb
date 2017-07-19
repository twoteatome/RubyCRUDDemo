class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.decimal :price
      t.string :image
      t.text :short_description
      t.text :full_description

      t.timestamps
    end
 
    create_table :users do |t|
      t.string :name
      t.string :password_digest

      t.timestamps
    end
 
    create_table :orders do |t|
      t.belongs_to :product, index: true
      t.belongs_to :user, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
