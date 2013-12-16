class RemoveColumnShoppers < ActiveRecord::Migration
  def change
  	remove_column :shoppers, :user_id, :string
  	remove_column :bizs, :email, :string
  	remove_column :bizs, :password_digest, :string
  end
end
