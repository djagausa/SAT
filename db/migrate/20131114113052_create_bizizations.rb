class CreateBizizations < ActiveRecord::Migration
  def change
    create_table :bizizations do |t|
      t.integer :shopper_id
      t.integer :biz_id

      t.timestamps
    end
  end
end
