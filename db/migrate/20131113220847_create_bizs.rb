class CreateBizs < ActiveRecord::Migration
  def change
    create_table :bizs do |t|
      t.string :name
      t.string :website
      t.string :logo_image

      t.timestamps
    end
  end
end
