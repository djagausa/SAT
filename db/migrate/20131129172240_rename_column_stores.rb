class RenameColumnStores < ActiveRecord::Migration
  def change
  	rename_column :stores, :longitude, :lng
  	rename_column :stores, :latitude, :lat
  end
end
