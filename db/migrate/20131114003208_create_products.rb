class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :original_price
      t.float :sale_price
      t.datetime :from_date
      t.datetime :to_date
      t.integer :category_id

      t.timestamps
    end
  end
end
