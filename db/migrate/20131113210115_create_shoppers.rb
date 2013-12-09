class CreateShoppers < ActiveRecord::Migration
  def change
    create_table :shoppers do |t|
      t.string :email
      t.string :password_digest
      t.boolean :home_page
      t.string :zip_code
      t.float :lng
      t.float :lat
      t.integer :distance

      t.timestamps
    end
  end
end
