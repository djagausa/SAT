class AddColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :biz_id, :integer
  end
end
