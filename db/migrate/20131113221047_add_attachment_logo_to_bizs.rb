class AddAttachmentLogoToBizs < ActiveRecord::Migration
  def self.up
    change_table :bizs do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :bizs, :logo
  end
end
