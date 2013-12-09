class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone_number
      t.string :contact_name
      t.string :hours
      t.string :days
      t.integer :biz_id
      t.float :lng
      t.float :lat

      t.timestamps
    end
  end
end
