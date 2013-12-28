class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :as_relation_superclass => true do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
