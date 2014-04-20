class ChangeBizsTable < ActiveRecord::Migration
  def change
  	change_table :bizs do |t|
      t.remove :email
      t.remove :password_digest
    end
    change_table :shoppers do |t|
      t.remove :email
      t.remove :password_digest
    end
  end
end
