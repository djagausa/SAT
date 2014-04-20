class CreateShoppers < ActiveRecord::Migration
  def change
    create_table :shoppers do |t|
      t.boolean :home_page
      t.string :zip_code
      t.float :lng
      t.float :lat
      t.integer :distance

      t.timestamps
    end
  end
end
